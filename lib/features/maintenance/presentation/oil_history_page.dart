import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/maintenance/application/maintenance_providers.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';
import 'package:go_router/go_router.dart';

class OilHistoryPage extends ConsumerWidget {
  const OilHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(selectedVehicleOilHistoryProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.oilHistory)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/oil/add'),
        child: const Icon(Icons.add),
      ),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (records) {
          if (records.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.oilHistoryEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.oilHistoryEmptyHint, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/oil/add'),
                      child: Text(l10n.addOilChange),
                    ),
                  ],
                ),
              ),
            );
          }

          final ascending = List<OilChange>.of(records)
            ..sort((a, b) => a.odometer.compareTo(b.odometer));
          final avgInterval = NextDueCalculator.averageOilIntervalKm(
            ascending.map((e) => e.odometer).toList(),
          );
          final avgCost = records.fold<int>(0, (s, e) => s + e.costPaisa) /
              records.length;

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: records.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    _stat(context, l10n.totalOilChanges, '${records.length}'),
                    _stat(
                      context,
                      l10n.avgOilInterval,
                      avgInterval == null
                          ? l10n.notEnoughData
                          : '${avgInterval.round()} km',
                    ),
                    _stat(
                      context,
                      l10n.avgOilCost,
                      currency.formatPaisa(avgCost.round()),
                    ),
                    _stat(
                      context,
                      l10n.latestOilBrand,
                      records.first.brand ?? '—',
                    ),
                  ],
                );
              }
              final OilChange oil = records[index - 1];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x1AE8A33C),
                    child: Icon(Icons.water_drop, color: AppColors.maintenance),
                  ),
                  title: Text(oil.displayLabel),
                  subtitle: Text(
                    [
                      MaterialLocalizations.of(context)
                          .formatMediumDate(oil.occurredOn),
                      '${oil.odometer} km',
                    ].join(' · '),
                  ),
                  trailing: Text(currency.formatPaisa(oil.costPaisa)),
                  onTap: () => context.push('/oil/${oil.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _stat(BuildContext context, String label, String value) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: Theme.of(context).textTheme.titleSmall),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
