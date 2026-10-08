import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/presentation/widgets/simple_bar_chart.dart';

class MaintenanceReportPage extends ConsumerWidget {
  const MaintenanceReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final year = ref.watch(reportYearProvider);
    final async = ref.watch(maintenanceReportProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceReport)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      ref.read(reportYearProvider.notifier).setYear(year - 1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    '$year',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final now = DateTime.now().year;
                    if (year < now) {
                      ref.read(reportYearProvider.notifier).setYear(year + 1);
                    }
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          Expanded(
            child: async.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(child: Text(l10n.commonError)),
              data: (report) {
                if (report == null) {
                  return Center(child: Text(l10n.selectedVehicleNone));
                }
                if (report.isEmpty) {
                  return Center(child: Text(l10n.reportEmpty));
                }
                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    MetricTile(
                      label: l10n.totalServiceCost,
                      value: currency.formatPaisa(report.totalServiceCostPaisa),
                    ),
                    MetricTile(
                      label: l10n.serviceCount,
                      value: '${report.serviceCount}',
                    ),
                    MetricTile(
                      label: l10n.averageServiceCost,
                      value: currency.formatMajor(
                        report.averageServiceCostPaisa / 100,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.commonServiceCategories,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ...report.commonCategories.map(
                      (c) => ListTile(
                        title: Text(c.nameEn),
                        subtitle: Text('${c.count}'),
                        trailing: Text(currency.formatPaisa(c.amountPaisa)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
