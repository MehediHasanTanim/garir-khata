import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/presentation/widgets/simple_bar_chart.dart';

class RepairReportPage extends ConsumerWidget {
  const RepairReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final year = ref.watch(reportYearProvider);
    final async = ref.watch(repairReportProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.repairReport)),
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
                      label: l10n.totalRepairCost,
                      value: currency.formatPaisa(report.totalRepairCostPaisa),
                    ),
                    MetricTile(
                      label: l10n.repairCount,
                      value: '${report.repairCount}',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.topRepairCategories,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ...report.topCategories.map(
                      (c) => ListTile(
                        title: Text(c.nameEn),
                        subtitle: Text('${c.count}'),
                        trailing: Text(currency.formatPaisa(c.amountPaisa)),
                      ),
                    ),
                    if (report.repeatedCategories.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.repeatedIssues,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.warning,
                            ),
                      ),
                      Text(
                        l10n.repeatedIssuesHint(report.repeatThreshold),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ...report.repeatedCategories.map(
                        (c) => ListTile(
                          leading: const Icon(
                            Icons.warning_amber_outlined,
                            color: AppColors.warning,
                          ),
                          title: Text(c.nameEn),
                          subtitle: Text('${c.count}×'),
                          trailing: Text(currency.formatPaisa(c.amountPaisa)),
                        ),
                      ),
                    ],
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
