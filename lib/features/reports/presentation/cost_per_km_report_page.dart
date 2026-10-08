import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/reports/presentation/widgets/simple_bar_chart.dart';
import 'package:intl/intl.dart';

class CostPerKmReportPage extends ConsumerWidget {
  const CostPerKmReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final month = ref.watch(reportMonthProvider);
    final mode = ref.watch(costPerKmModeProvider);
    final selected = ref.watch(costPerKmCategoriesProvider);
    final async = ref.watch(costPerKmReportProvider);
    final categoriesAsync = ref.watch(expenseCategoriesProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );
    final label = DateFormat.yMMMM(Localizations.localeOf(context).toString())
        .format(month);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.costPerKmReport)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Row(
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
                onPressed: () => ref.read(reportMonthProvider.notifier).next(),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              ChoiceChip(
                label: Text(l10n.costPerKmFuelOnly),
                selected: mode == CostPerKmMode.fuelOnly,
                onSelected: (_) => ref
                    .read(costPerKmModeProvider.notifier)
                    .setMode(CostPerKmMode.fuelOnly),
              ),
              ChoiceChip(
                label: Text(l10n.costPerKmOperating),
                selected: mode == CostPerKmMode.operating,
                onSelected: (_) => ref
                    .read(costPerKmModeProvider.notifier)
                    .setMode(CostPerKmMode.operating),
              ),
              ChoiceChip(
                label: Text(l10n.costPerKmCustom),
                selected: mode == CostPerKmMode.custom,
                onSelected: (_) => ref
                    .read(costPerKmModeProvider.notifier)
                    .setMode(CostPerKmMode.custom),
              ),
            ],
          ),
          if (mode == CostPerKmMode.custom) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.selectCategories,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            categoriesAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => Text(l10n.commonError),
              data: (cats) => Wrap(
                spacing: AppSpacing.xs,
                children: cats.map((c) {
                  final on = selected.contains(c.code);
                  return FilterChip(
                    label: Text(c.nameEn),
                    selected: on,
                    onSelected: (_) => ref
                        .read(costPerKmCategoriesProvider.notifier)
                        .toggle(c.code),
                  );
                }).toList(),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          async.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Text(l10n.commonError),
            data: (report) {
              if (report == null) {
                return Text(l10n.selectedVehicleNone);
              }
              final result = report.result;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MetricTile(
                    label: l10n.distance,
                    value: '${result.distanceKm} km',
                  ),
                  MetricTile(
                    label: l10n.fieldTotalCost,
                    value: currency.formatPaisa(result.totalExpensePaisa),
                  ),
                  MetricTile(
                    label: l10n.costPerKm,
                    value: result.isAvailable && result.costPerKmMajor != null
                        ? currency.formatMajor(result.costPerKmMajor!)
                        : l10n.notEnoughData,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.howCalculated,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(report.formulaExplanation),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
