import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:intl/intl.dart';

class MonthlyExpenseReportPage extends ConsumerWidget {
  const MonthlyExpenseReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final month = ref.watch(reportMonthProvider);
    final async = ref.watch(monthlyExpenseReportProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );
    final label = DateFormat.yMMMM(Localizations.localeOf(context).toString())
        .format(month);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.monthlyExpenseReport)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      ref.read(reportMonthProvider.notifier).previous(),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      ref.read(reportMonthProvider.notifier).next(),
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
                    _row(l10n.fuel, report.fuelPaisa, AppColors.fuel, currency),
                    _row(
                      l10n.maintenance,
                      report.maintenancePaisa,
                      AppColors.maintenance,
                      currency,
                    ),
                    _row(
                      l10n.repairs,
                      report.repairPaisa,
                      AppColors.repair,
                      currency,
                    ),
                    _row(
                      l10n.documents,
                      report.documentsPaisa,
                      AppColors.other,
                      currency,
                    ),
                    _row(
                      l10n.other,
                      report.otherPaisa,
                      AppColors.textSecondary,
                      currency,
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(l10n.fieldTotalCost),
                      trailing: Text(
                        currency.formatPaisa(report.totalPaisa),
                        style: Theme.of(context).textTheme.titleLarge,
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

  Widget _row(
    String label,
    int paisa,
    Color color,
    CurrencyFormatter currency,
  ) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color, radius: 6),
      title: Text(label),
      trailing: Text(currency.formatPaisa(paisa)),
    );
  }
}
