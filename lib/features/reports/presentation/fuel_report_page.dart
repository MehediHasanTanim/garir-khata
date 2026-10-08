import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/presentation/widgets/simple_bar_chart.dart';

class FuelReportPage extends ConsumerWidget {
  const FuelReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final year = ref.watch(reportYearProvider);
    final async = ref.watch(fuelReportProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fuelReport)),
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
                final avgPrice = report.averagePricePerLiterPaisa;
                final mileage = report.averageMileageKmPerLiter;
                final costKm = report.fuelCostPerKm;
                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 48) / 2,
                          child: MetricTile(
                            label: l10n.totalLiters,
                            value: report.totalLiters.toStringAsFixed(1),
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 48) / 2,
                          child: MetricTile(
                            label: l10n.totalFuelSpend,
                            value: currency.formatPaisa(report.totalSpendPaisa),
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 48) / 2,
                          child: MetricTile(
                            label: l10n.averagePricePerLiter,
                            value: avgPrice == null
                                ? l10n.notEnoughData
                                : currency.formatPaisa(avgPrice.round()),
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 48) / 2,
                          child: MetricTile(
                            label: l10n.distance,
                            value: '${report.distanceKm} km',
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 48) / 2,
                          child: MetricTile(
                            label: l10n.averageMileage,
                            value: mileage == null
                                ? l10n.notEnoughData
                                : '${mileage.toStringAsFixed(1)} km/L',
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 48) / 2,
                          child: MetricTile(
                            label: l10n.fuelCostPerKm,
                            value: costKm.isAvailable && costKm.costPerKmMajor != null
                                ? currency.formatMajor(costKm.costPerKmMajor!)
                                : l10n.notEnoughData,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.monthlyFuelCost,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SimpleBarChart(
                      points: report.monthlyFuelCostPaisa,
                      color: AppColors.fuel,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.fuelPriceTrend,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SimpleBarChart(
                      points: report.priceTrendPaisaPerLiter,
                      color: AppColors.primaryLight,
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
