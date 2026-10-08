import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/files/app_storage_paths.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/security/temp_file_cleaner.dart';
import 'package:garir_khata/core/ui/app_states.dart';
import 'package:garir_khata/features/attachments/application/attachment_providers.dart';
import 'package:go_router/go_router.dart';

class DataStoragePage extends ConsumerWidget {
  const DataStoragePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final storage = ref.watch(fileStorageServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsDataBackup)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          FutureBuilder<({int db, int attachments})>(
            future: _sizes(storage.filesRoot),
            builder: (context, snap) {
              final db = snap.data?.db ?? 0;
              final att = snap.data?.attachments ?? 0;
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.databaseSize),
                    subtitle: Text(_fmt(db)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.attachmentsSize),
                    subtitle: Text(_fmt(att)),
                  ),
                ],
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: Text(l10n.exportDataTitle),
            onTap: () => context.push('/export'),
          ),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: Text(l10n.backupRestoreTitle),
            onTap: () => context.push('/backup'),
          ),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: Text(l10n.clearTempFiles),
            onTap: () async {
              final cleaner = TempFileCleaner(
                storage: storage,
                logger: ref.read(appLoggerProvider),
              );
              final n = await cleaner.cleanup(
                olderThan: Duration.zero,
              );
              if (!context.mounted) {
                return;
              }
              showSaveFeedback(
                context,
                success: true,
                message: l10n.tempFilesCleared(n),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<({int db, int attachments})> _sizes(Directory filesRoot) async {
    var att = 0;
    if (await filesRoot.exists()) {
      await for (final e in filesRoot.list(recursive: true)) {
        if (e is File) {
          att += await e.length();
        }
      }
    }
    var db = 0;
    try {
      final dbFile = await AppStoragePaths.databaseFile();
      if (await dbFile.exists()) {
        db = await dbFile.length();
      }
    } on Object {
      db = 0;
    }
    return (db: db, attachments: att);
  }

  String _fmt(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
