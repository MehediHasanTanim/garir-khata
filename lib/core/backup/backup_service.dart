import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart';
import 'package:garir_khata/core/backup/backup_encryption.dart';
import 'package:garir_khata/core/backup/backup_models.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

typedef DatabaseSnapshotFn = Future<File> Function(Directory tempDir);

class BackupService {
  BackupService({
    required this.db,
    required this.storage,
    required this.uuidGenerator,
    required this.clock,
    required this.snapshotDatabase,
    this.appVersion = '1.0.0',
  });

  final AppDatabase db;
  final FileStorageService storage;
  final UuidGenerator uuidGenerator;
  final Clock clock;
  final DatabaseSnapshotFn snapshotDatabase;
  final String appVersion;

  Future<Result<BackupCreateResult>> createBackup({
    String? password,
    bool includeAttachments = true,
    Directory? outputDirectory,
  }) async {
    final String historyId = uuidGenerator.v4();
    try {
      await storage.ensureReady();
      final Directory outDir = outputDirectory ?? storage.backupsRoot;
      await outDir.create(recursive: true);

      await db.customStatement('PRAGMA wal_checkpoint(FULL)');

      final Directory work = Directory(
        p.join(storage.tempRoot.path, 'backup_${uuidGenerator.v4()}'),
      );
      await work.create(recursive: true);

      final File dbSnap = await snapshotDatabase(work);
      final dbBytes = await dbSnap.readAsBytes();
      final dbChecksum = FileStorageService.checksumOfBytes(dbBytes);

      final archive = Archive();
      archive.addFile(
        ArchiveFile('database.sqlite', dbBytes.length, dbBytes),
      );

      var attachmentCount = 0;
      if (includeAttachments) {
        final files = await storage.listAttachmentFiles();
        for (final file in files) {
          final rel = storage.relativeFromAbsolute(file.path);
          final bytes = await file.readAsBytes();
          archive.addFile(
            ArchiveFile('attachments/$rel', bytes.length, bytes),
          );
          attachmentCount++;
        }
      }

      final metadata = await _buildMetadata();
      final metadataJson = utf8.encode(
        const JsonEncoder.withIndent('  ').convert(metadata.toJson()),
      );
      archive.addFile(
        ArchiveFile('metadata.json', metadataJson.length, metadataJson),
      );

      final stagedManifest = BackupManifest(
        formatVersion: BackupManifest.currentFormatVersion,
        appVersion: appVersion,
        createdAt: clock.now(),
        vehicleCount: metadata.vehicleNicknames.length,
        databaseSchemaVersion: db.schemaVersion,
        encrypted: password != null && password.isNotEmpty,
        attachmentCount: attachmentCount,
        databaseChecksum: dbChecksum,
        archiveChecksum: 'pending',
        includeAttachments: includeAttachments,
      );

      // First encode without final archive checksum, then re-encode.
      final draftZip = _encodeWithManifest(archive, stagedManifest);
      final archiveChecksum = FileStorageService.checksumOfBytes(draftZip);
      final finalManifest = BackupManifest(
        formatVersion: stagedManifest.formatVersion,
        appVersion: stagedManifest.appVersion,
        createdAt: stagedManifest.createdAt,
        vehicleCount: stagedManifest.vehicleCount,
        databaseSchemaVersion: stagedManifest.databaseSchemaVersion,
        encrypted: stagedManifest.encrypted,
        attachmentCount: stagedManifest.attachmentCount,
        databaseChecksum: stagedManifest.databaseChecksum,
        archiveChecksum: archiveChecksum,
        includeAttachments: stagedManifest.includeAttachments,
      );
      final finalZip = _encodeWithManifest(archive, finalManifest);

      final wrapped = await BackupEncryption.wrap(
        zipBytes: finalZip,
        password: password,
      );
      if (wrapped case Failure(:final error)) {
        await _recordHistory(
          id: historyId,
          path: '',
          size: 0,
          vehicleCount: finalManifest.vehicleCount,
          status: BackupHistoryStatus.failed,
          includeAttachments: includeAttachments,
          error: error.message,
        );
        return Failure(error);
      }
      final envelope = (wrapped as Success<Uint8List>).data;

      final stamp = DateFormat('yyyyMMdd_HHmm').format(clock.now());
      final outPath =
          p.join(outDir.path, 'garir_khata_backup_$stamp.gkbackup');
      await File(outPath).writeAsBytes(envelope, flush: true);

      await _recordHistory(
        id: historyId,
        path: outPath,
        size: envelope.length,
        vehicleCount: finalManifest.vehicleCount,
        status: BackupHistoryStatus.success,
        includeAttachments: includeAttachments,
      );

      if (await work.exists()) {
        await work.delete(recursive: true);
      }

      return Success(
        BackupCreateResult(
          filePath: outPath,
          sizeBytes: envelope.length,
          manifest: finalManifest,
          historyId: historyId,
        ),
      );
    } on Object catch (error) {
      await _recordHistory(
        id: historyId,
        path: '',
        size: 0,
        vehicleCount: 0,
        status: BackupHistoryStatus.failed,
        includeAttachments: includeAttachments,
        error: '$error',
      );
      return Failure(
        FileError(message: 'Failed to create backup', cause: error),
      );
    }
  }

  Future<Result<List<BackupHistoryEntry>>> listHistory() async {
    try {
      final rows = await (db.select(db.backupHistory)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
      return Success(
        rows
            .map(
              (r) => BackupHistoryEntry(
                id: r.id,
                createdAt: r.createdAt,
                pathOrUri: r.pathOrUri,
                sizeBytes: r.sizeBytes,
                vehicleCount: r.vehicleCount,
                schemaVersion: r.schemaVersion,
                status: switch (r.status) {
                  'failed' => BackupHistoryStatus.failed,
                  'interrupted' => BackupHistoryStatus.interrupted,
                  _ => BackupHistoryStatus.success,
                },
                includeAttachments: r.includeAttachments,
                errorMessage: r.errorMessage,
              ),
            )
            .toList(),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load backup history', cause: error),
      );
    }
  }

  Uint8List _encodeWithManifest(Archive base, BackupManifest manifest) {
    final archive = Archive();
    for (final file in base.files) {
      if (file.name == 'manifest.json') {
        continue;
      }
      archive.addFile(file);
    }
    final bytes = utf8.encode(
      const JsonEncoder.withIndent('  ').convert(manifest.toJson()),
    );
    archive.addFile(ArchiveFile('manifest.json', bytes.length, bytes));
    return Uint8List.fromList(ZipEncoder().encode(archive));
  }

  Future<BackupMetadata> _buildMetadata() async {
    final vehicles = await db.select(db.vehicles).get();
    Future<int> count(String sql) async {
      final row = await db.customSelect(sql).getSingle();
      return row.read<int>('c');
    }

    return BackupMetadata(
      createdAt: clock.now(),
      vehicleNicknames: vehicles.map((v) => v.nickname).toList(),
      recordCounts: {
        'fuel': await count('SELECT COUNT(*) AS c FROM fuel_entries'),
        'expenses': await count('SELECT COUNT(*) AS c FROM expenses'),
        'services': await count('SELECT COUNT(*) AS c FROM service_records'),
        'repairs': await count('SELECT COUNT(*) AS c FROM repairs'),
        'documents':
            await count('SELECT COUNT(*) AS c FROM vehicle_documents'),
        'odometer': await count('SELECT COUNT(*) AS c FROM odometer_entries'),
      },
    );
  }

  Future<void> _recordHistory({
    required String id,
    required String path,
    required int size,
    required int vehicleCount,
    required BackupHistoryStatus status,
    required bool includeAttachments,
    String? error,
  }) async {
    await db.into(db.backupHistory).insert(
          BackupHistoryCompanion.insert(
            id: id,
            createdAt: clock.now(),
            pathOrUri: path,
            sizeBytes: size,
            vehicleCount: Value(vehicleCount),
            schemaVersion: db.schemaVersion,
            status: status.name,
            includeAttachments: Value(includeAttachments),
            errorMessage: Value(error),
          ),
        );
  }
}
