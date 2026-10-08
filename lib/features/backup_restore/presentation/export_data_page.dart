import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/export/csv_export_service.dart';
import 'package:garir_khata/features/backup_restore/application/backup_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:share_plus/share_plus.dart';

class ExportDataPage extends ConsumerStatefulWidget {
  const ExportDataPage({super.key});

  @override
  ConsumerState<ExportDataPage> createState() => _ExportDataPageState();
}

class _ExportDataPageState extends ConsumerState<ExportDataPage> {
  CsvExportKind _kind = CsvExportKind.fuel;
  DateTimeRange? _range;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final vehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.exportDataTitle)),
      body: vehicle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (v) {
          if (v == null) {
            return Center(child: Text(l10n.selectedVehicleNone));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(v.nickname, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.exportKind, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                children: CsvExportKind.values.map((kind) {
                  return ChoiceChip(
                    label: Text(_label(l10n, kind)),
                    selected: _kind == kind,
                    onSelected: (_) => setState(() => _kind = kind),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.exportDateRange),
                subtitle: Text(
                  _range == null
                      ? l10n.exportAllDates
                      : '${MaterialLocalizations.of(context).formatMediumDate(_range!.start)} – ${MaterialLocalizations.of(context).formatMediumDate(_range!.end)}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(now.year - 10),
                      lastDate: now,
                      initialDateRange: _range,
                    );
                    if (picked != null) {
                      setState(() => _range = picked);
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _range = null),
                child: Text(l10n.commonClear),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: _busy
                    ? null
                    : () async {
                        setState(() => _busy = true);
                        final result =
                            await ref.read(csvExportServiceProvider).export(
                                  CsvExportRequest(
                                    kind: _kind,
                                    vehicleId: v.id,
                                    from: _range?.start,
                                    to: _range?.end.add(const Duration(days: 1)),
                                  ),
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
                        final file = result.dataOrNull!;
                        await SharePlus.instance.share(
                          ShareParams(
                            files: [XFile(file.filePath)],
                            subject: l10n.exportDataTitle,
                          ),
                        );
                      },
                child: Text(_busy ? l10n.commonLoading : l10n.exportAction),
              ),
            ],
          );
        },
      ),
    );
  }

  String _label(AppLocalizations l10n, CsvExportKind kind) => switch (kind) {
        CsvExportKind.fuel => l10n.fuel,
        CsvExportKind.expenses => l10n.expense,
        CsvExportKind.service => l10n.service,
        CsvExportKind.repairs => l10n.repairs,
        CsvExportKind.odometer => l10n.odometer,
        CsvExportKind.documents => l10n.documents,
      };
}
