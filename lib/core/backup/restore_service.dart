import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:garir_khata/core/backup/backup_encryption.dart';
import 'package:garir_khata/core/backup/backup_models.dart';
import 'package:garir_khata/core/backup/backup_service.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:path/path.dart' as p;

typedef ReminderRescheduleFn = Future<void> Function();
typedef DatabaseReplaceFn = Future<void> Function(File restoredDbFile);

class RestoreService {
  RestoreService({
    required this.db,
    required this.storage,
    required this.backupService,
    required this.uuidGenerator,
    required this.clock,
    required this.replaceDatabase,
    this.rescheduleReminders,
  });

  final AppDatabase db;
  final FileStorageService storage;
  final BackupService backupService;
  final UuidGenerator uuidGenerator;
  final Clock clock;
  final DatabaseReplaceFn replaceDatabase;
  final ReminderRescheduleFn? rescheduleReminders;

  Future<Result<RestoreSummary>> inspect({
    required Uint8List envelope,
    String? password,
  }) async {
    try {
      final encrypted = BackupEncryption.isEncrypted(envelope);
      if (encrypted && (password == null || password.isEmpty)) {
        // Partial summary for UI password prompt — use placeholder metadata.
        return Success(
          RestoreSummary(
            manifest: BackupManifest(
              formatVersion: BackupManifest.currentFormatVersion,
              appVersion: '',
              createdAt: clock.now(),
              vehicleCount: 0,
              databaseSchemaVersion: 0,
              encrypted: true,
              attachmentCount: 0,
              databaseChecksum: '',
              archiveChecksum: '',
            ),
            metadata: BackupMetadata(
              createdAt: clock.now(),
              vehicleNicknames: const [],
              recordCounts: const {},
            ),
            requiresPassword: true,
            warnings: const ['Encrypted backup — password required'],
          ),
        );
      }

      final unzipped = await BackupEncryption.unwrap(
        envelope: envelope,
        password: password,
      );
      if (unzipped case Failure(:final error)) {
        if (error is ValidationError &&
            error.message.contains('Wrong backup password')) {
          return Failure(error);
        }
        return Failure(
          FileError(message: 'Corrupt backup', cause: error, code: 'corrupt'),
        );
      }
      final zipBytes = (unzipped as Success<Uint8List>).data;
      final archive = ZipDecoder().decodeBytes(zipBytes);

      final manifestFile = archive.findFile('manifest.json');
      final metadataFile = archive.findFile('metadata.json');
      final dbFile = archive.findFile('database.sqlite');
      if (manifestFile == null || metadataFile == null || dbFile == null) {
        return const Failure(
          FileError(message: 'Corrupt backup', code: 'corrupt'),
        );
      }

      final manifest = BackupManifest.fromJson(
        Map<String, Object?>.from(
          jsonDecode(utf8.decode(manifestFile.content)) as Map,
        ),
      );
      final metadata = BackupMetadata.fromJson(
        Map<String, Object?>.from(
          jsonDecode(utf8.decode(metadataFile.content)) as Map,
        ),
      );

      if (manifest.formatVersion < BackupManifest.minSupportedFormatVersion ||
          manifest.formatVersion > BackupManifest.currentFormatVersion) {
        return Failure(
          ValidationError(
            message: 'Unsupported backup version ${manifest.formatVersion}',
            code: 'unsupported_version',
          ),
        );
      }

      final dbBytes = dbFile.content;
      final dbChecksum = FileStorageService.checksumOfBytes(dbBytes);
      final warnings = <String>[];
      if (manifest.databaseChecksum.isNotEmpty &&
          manifest.databaseChecksum != dbChecksum) {
        return const Failure(
          FileError(message: 'Corrupt backup checksum', code: 'corrupt'),
        );
      }
      if (manifest.databaseSchemaVersion < db.schemaVersion) {
        warnings.add(
          'Older schema v${manifest.databaseSchemaVersion} — migrations will run',
        );
      }
      if (manifest.databaseSchemaVersion > db.schemaVersion) {
        return Failure(
          ValidationError(
            message:
                'Backup schema v${manifest.databaseSchemaVersion} is newer than this app',
            code: 'unsupported_version',
          ),
        );
      }

      // Soft-check attachment presence.
      if (manifest.includeAttachments) {
        final attached = archive.files
            .where((f) => f.name.startsWith('attachments/') && f.isFile)
            .length;
        if (attached < manifest.attachmentCount) {
          warnings.add('Some attachments are missing from the archive');
        }
      }

      return Success(
        RestoreSummary(
          manifest: manifest,
          metadata: metadata,
          requiresPassword: false,
          warnings: warnings,
        ),
      );
    } on Object catch (error) {
      return Failure(
        FileError(message: 'Corrupt backup', cause: error, code: 'corrupt'),
      );
    }
  }

  Future<Result<RestoreOutcome>> restore({
    required Uint8List envelope,
    String? password,
    bool createSafetyBackup = true,
  }) async {
    Directory? work;
    try {
      final inspected = await inspect(envelope: envelope, password: password);
      if (inspected case Failure(:final error)) {
        final phase = switch (error.code) {
          'unsupported_version' => RestorePhase.unsupportedVersion,
          'corrupt' => RestorePhase.corrupt,
          _ => RestorePhase.failed,
        };
        return Success(RestoreOutcome(phase: phase, message: error.message));
      }
      final summary = (inspected as Success<RestoreSummary>).data;
      if (summary.requiresPassword) {
        return const Success(
          RestoreOutcome(
            phase: RestorePhase.failed,
            message: 'Password required',
          ),
        );
      }

      if (createSafetyBackup) {
        final safety = await backupService.createBackup(
          includeAttachments: true,
          password: null,
        );
        if (safety.isFailure) {
          return Success(
            RestoreOutcome(
              phase: RestorePhase.failed,
              message: 'Could not create safety backup before restore',
              summary: summary,
            ),
          );
        }
      }

      final unzipped = await BackupEncryption.unwrap(
        envelope: envelope,
        password: password,
      );
      if (unzipped case Failure(:final error)) {
        return Success(
          RestoreOutcome(phase: RestorePhase.corrupt, message: error.message),
        );
      }
      final zipBytes = (unzipped as Success<Uint8List>).data;
      final archive = ZipDecoder().decodeBytes(zipBytes);

      work = Directory(
        p.join(storage.tempRoot.path, 'restore_${uuidGenerator.v4()}'),
      );
      await work.create(recursive: true);

      final dbEntry = archive.findFile('database.sqlite');
      if (dbEntry == null) {
        return const Success(
          RestoreOutcome(
            phase: RestorePhase.corrupt,
            message: 'Missing database in backup',
          ),
        );
      }
      final restoredDb = File(p.join(work.path, 'database.sqlite'));
      await restoredDb.writeAsBytes(dbEntry.content, flush: true);

      // Replace attachments directory.
      await storage.ensureReady();
      if (await storage.filesRoot.exists()) {
        await storage.filesRoot.delete(recursive: true);
      }
      await storage.filesRoot.create(recursive: true);
      for (final file in archive.files) {
        if (!file.isFile || !file.name.startsWith('attachments/')) {
          continue;
        }
        final rel = file.name.substring('attachments/'.length);
        final out = File(p.join(storage.filesRoot.path, rel));
        await out.parent.create(recursive: true);
        await out.writeAsBytes(file.content, flush: true);
      }

      await replaceDatabase(restoredDb);

      if (rescheduleReminders != null) {
        await rescheduleReminders!();
      }

      await work.delete(recursive: true);

      return Success(
        RestoreOutcome(
          phase: RestorePhase.success,
          summary: summary,
          message: 'Restore completed',
        ),
      );
    } on Object catch (error) {
      return Success(
        RestoreOutcome(
          phase: RestorePhase.failed,
          message: 'Restore failed: $error',
        ),
      );
    }
  }
}
