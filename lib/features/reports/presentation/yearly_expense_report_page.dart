import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/reports/presentation/widgets/simple_bar_chart.dart';

class YearlyExpenseReportPage extends ConsumerWidget {
  const YearlyExpenseReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final year = ref.watch(reportYearProvider);
    final async = ref.watch(yearlyExpenseReportProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.yearlyExpenseReport)),
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
                final points = List.generate(
                  12,
                  (i) => MonthlyPoint(
                    monthStart: DateTime(year, i + 1),
                    value: report.monthlyTotalsPaisa[i].toDouble(),
                  ),
                );
                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    MetricTile(
                      label: l10n.annualTotal,
                      value: currency.formatPaisa(report.annualTotalPaisa),
                    ),
                    MetricTile(
                      label: l10n.monthlyAverage,
                      value: currency.formatMajor(report.monthlyAveragePaisa / 100),
                    ),
                    MetricTile(
                      label: l10n.highestMonth,
                      value:
                          '${_monthName(report.highestMonth)} · ${currency.formatPaisa(report.highestMonthPaisa)}',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.monthlyBreakdown,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SimpleBarChart(points: points),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.categoryBreakdown,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ...report.categoryBreakdown.map(
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

  String _monthName(int month) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return names[month - 1];
  }
}
