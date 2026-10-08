import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/backup/backup_models.dart';
import 'package:garir_khata/core/backup/backup_service.dart';
import 'package:garir_khata/core/backup/restore_service.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/export/csv_export_service.dart';
import 'package:garir_khata/core/files/app_storage_paths.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/attachments/application/attachment_providers.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:path/path.dart' as p;

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    db: ref.watch(appDatabaseProvider),
    storage: ref.watch(fileStorageServiceProvider),
    uuidGenerator: const DefaultUuidGenerator(),
    clock: const SystemClock(),
    snapshotDatabase: AppStoragePaths.snapshotDatabaseTo,
  );
});

final restoreServiceProvider = Provider<RestoreService>((ref) {
  return RestoreService(
    db: ref.watch(appDatabaseProvider),
    storage: ref.watch(fileStorageServiceProvider),
    backupService: ref.watch(backupServiceProvider),
    uuidGenerator: const DefaultUuidGenerator(),
    clock: const SystemClock(),
    replaceDatabase: (restoredDb) async {
      // Close current DB, replace file, reopen via provider invalidation.
      final current = ref.read(appDatabaseProvider);
      await current.close();
      final target = await AppStoragePaths.databaseFile();
      await target.parent.create(recursive: true);
      if (await target.exists()) {
        await target.delete();
      }
      await restoredDb.copy(target.path);
      for (final suffix in ['-wal', '-shm']) {
        final side = File('${target.path}$suffix');
        if (await side.exists()) {
          await side.delete();
        }
      }
      ref.invalidate(appDatabaseProvider);
      // Force open + migrate.
      ref.read(appDatabaseProvider);
    },
    rescheduleReminders: () async {
      await ref.read(reminderEngineProvider).evaluateAll();
    },
  );
});

final csvExportServiceProvider = Provider<CsvExportService>((ref) {
  return CsvExportService(
    db: ref.watch(appDatabaseProvider),
    storage: ref.watch(fileStorageServiceProvider),
    uuidGenerator: const DefaultUuidGenerator(),
    clock: const SystemClock(),
  );
});

final backupHistoryProvider =
    FutureProvider<List<BackupHistoryEntry>>((ref) async {
  final result = await ref.watch(backupServiceProvider).listHistory();
  return result.when(success: (v) => v, failure: (e) => throw e);
});

/// Test helper: file-backed snapshot from an open Drift NativeDatabase path.
Future<File> snapshotOpenSqliteFile(String dbPath, Directory tempDir) async {
  final source = File(dbPath);
  final dest = File(p.join(tempDir.path, 'database.sqlite'));
  await source.copy(dest.path);
  return dest;
}
