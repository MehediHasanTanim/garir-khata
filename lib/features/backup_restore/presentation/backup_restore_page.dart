import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/backup/backup_models.dart';
import 'package:garir_khata/features/backup_restore/application/backup_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class BackupRestorePage extends ConsumerWidget {
  const BackupRestorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(backupHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.backupRestoreTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.backup_outlined),
              title: Text(l10n.createBackup),
              subtitle: Text(l10n.createBackupHint),
              onTap: () => context.push('/backup/create'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.restore_outlined),
              title: Text(l10n.restoreBackup),
              subtitle: Text(l10n.restoreBackupHint),
              onTap: () => context.push('/backup/restore'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.backupHistory,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          history.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Text(l10n.commonError),
            data: (items) {
              if (items.isEmpty) {
                return Text(l10n.backupHistoryEmpty);
              }
              return Column(
                children: items.map((e) {
                  return ListTile(
                    title: Text(
                      MaterialLocalizations.of(context)
                          .formatMediumDate(e.createdAt),
                    ),
                    subtitle: Text(
                      '${(e.sizeBytes / 1024).toStringAsFixed(1)} KB · '
                      'v${e.schemaVersion} · ${e.status.name}',
                    ),
                    trailing: e.pathOrUri.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.share_outlined),
                            onPressed: () async {
                              if (await File(e.pathOrUri).exists()) {
                                await SharePlus.instance.share(
                                  ShareParams(files: [XFile(e.pathOrUri)]),
                                );
                              }
                            },
                          ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CreateBackupPage extends ConsumerStatefulWidget {
  const CreateBackupPage({super.key});

  @override
  ConsumerState<CreateBackupPage> createState() => _CreateBackupPageState();
}

class _CreateBackupPageState extends ConsumerState<CreateBackupPage> {
  bool _includeAttachments = true;
  final _password = TextEditingController();
  bool _busy = false;
  String? _resultPath;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.createBackup)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          SwitchListTile(
            title: Text(l10n.includeAttachments),
            value: _includeAttachments,
            onChanged: _busy
                ? null
                : (v) => setState(() => _includeAttachments = v),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              labelText: l10n.backupPasswordOptional,
              helperText: l10n.backupPasswordHint,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _busy
                ? null
                : () async {
                    setState(() {
                      _busy = true;
                      _resultPath = null;
                    });
                    final result =
                        await ref.read(backupServiceProvider).createBackup(
                              includeAttachments: _includeAttachments,
                              password: _password.text.trim().isEmpty
                                  ? null
                                  : _password.text.trim(),
                            );
                    setState(() => _busy = false);
                    if (!context.mounted) {
                      return;
                    }
                    if (result.isFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.commonError)),
                      );
                      return;
                    }
                    final created = result.dataOrNull!;
                    setState(() => _resultPath = created.filePath);
                    ref.invalidate(backupHistoryProvider);
                    await SharePlus.instance.share(
                      ShareParams(files: [XFile(created.filePath)]),
                    );
                  },
            child: Text(_busy ? l10n.commonLoading : l10n.createBackup),
          ),
          if (_resultPath != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(l10n.backupSuccess),
            Text(_resultPath!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}

class RestoreBackupPage extends ConsumerStatefulWidget {
  const RestoreBackupPage({super.key});

  @override
  ConsumerState<RestoreBackupPage> createState() => _RestoreBackupPageState();
}

class _RestoreBackupPageState extends ConsumerState<RestoreBackupPage> {
  RestorePhase _phase = RestorePhase.reading;
  RestoreSummary? _summary;
  String? _message;
  Uint8List? _envelope;
  final _password = TextEditingController();
  bool _understood = false;
  bool _busy = false;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.restoreBackup)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(_phaseLabel(l10n), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          if (_envelope == null)
            FilledButton(
              onPressed: _pick,
              child: Text(l10n.chooseBackupFile),
            ),
          if (_summary?.requiresPassword == true ||
              (_envelope != null &&
                  _summary == null &&
                  _phase == RestorePhase.validating)) ...[
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(labelText: l10n.backupPassword),
            ),
            FilledButton(
              onPressed: _busy ? null : _inspect,
              child: Text(l10n.validateBackup),
            ),
          ],
          if (_summary != null && !_summary!.requiresPassword) ...[
            Text('${l10n.backupDate}: ${_summary!.manifest.createdAt}'),
            Text(
              '${l10n.vehicles}: ${_summary!.metadata.vehicleNicknames.join(', ')}',
            ),
            Text(
              '${l10n.attachmentsTitle}: ${_summary!.manifest.attachmentCount}',
            ),
            Text(
              '${l10n.schemaVersion}: ${_summary!.manifest.databaseSchemaVersion}',
            ),
            ..._summary!.warnings.map(Text.new),
            const SizedBox(height: AppSpacing.md),
            CheckboxListTile(
              value: _understood,
              onChanged: (v) => setState(() => _understood = v ?? false),
              title: Text(l10n.restoreUnderstand),
            ),
            FilledButton(
              onPressed: !_understood || _busy ? null : _restore,
              child: Text(l10n.restoreAction),
            ),
          ],
          if (_message != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(_message!),
          ],
          if (_phase == RestorePhase.success)
            FilledButton(
              onPressed: () => context.go('/home'),
              child: Text(l10n.goToDashboard),
            ),
        ],
      ),
    );
  }

  String _phaseLabel(AppLocalizations l10n) => switch (_phase) {
        RestorePhase.reading => l10n.restorePhaseReading,
        RestorePhase.validating => l10n.restorePhaseValidating,
        RestorePhase.summary => l10n.restorePhaseSummary,
        RestorePhase.confirm => l10n.restorePhaseConfirm,
        RestorePhase.restoring => l10n.restorePhaseRestoring,
        RestorePhase.success => l10n.restorePhaseSuccess,
        RestorePhase.failed => l10n.restorePhaseFailed,
        RestorePhase.corrupt => l10n.restorePhaseCorrupt,
        RestorePhase.unsupportedVersion => l10n.restorePhaseUnsupported,
      };

  Future<void> _pick() async {
    setState(() {
      _phase = RestorePhase.reading;
      _message = null;
      _summary = null;
    });
    final files = await FilePicker.pickFiles(
      type: FileType.any,
      allowedExtensions: null,
    );
    if (files.isEmpty) {
      return;
    }
    final file = files.first;
    final bytes = await file.readAsBytes();
    setState(() {
      _envelope = bytes;
      _phase = RestorePhase.validating;
    });
    await _inspect();
  }

  Future<void> _inspect() async {
    if (_envelope == null) {
      return;
    }
    setState(() {
      _busy = true;
      _phase = RestorePhase.validating;
    });
    final result = await ref.read(restoreServiceProvider).inspect(
          envelope: _envelope!,
          password: _password.text.trim().isEmpty
              ? null
              : _password.text.trim(),
        );
    setState(() => _busy = false);
    if (result.isFailure) {
      final err = result.errorOrNull!;
      setState(() {
        _phase = switch (err.code) {
          'unsupported_version' => RestorePhase.unsupportedVersion,
          'corrupt' => RestorePhase.corrupt,
          _ => RestorePhase.failed,
        };
        _message = err.message;
      });
      return;
    }
    final summary = result.dataOrNull!;
    setState(() {
      _summary = summary;
      _phase = summary.requiresPassword
          ? RestorePhase.validating
          : RestorePhase.summary;
    });
  }

  Future<void> _restore() async {
    if (_envelope == null) {
      return;
    }
    setState(() {
      _busy = true;
      _phase = RestorePhase.restoring;
    });
    final result = await ref.read(restoreServiceProvider).restore(
          envelope: _envelope!,
          password: _password.text.trim().isEmpty
              ? null
              : _password.text.trim(),
        );
    setState(() => _busy = false);
    final outcome = result.dataOrNull;
    if (outcome == null) {
      setState(() {
        _phase = RestorePhase.failed;
        _message = result.errorOrNull?.message;
      });
      return;
    }
    setState(() {
      _phase = outcome.phase;
      _message = outcome.message;
      _summary = outcome.summary ?? _summary;
    });
    ref.invalidate(backupHistoryProvider);
  }
}
