import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/maintenance/application/maintenance_providers.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:go_router/go_router.dart';

class ServiceHistoryPage extends ConsumerWidget {
  const ServiceHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(selectedVehicleServiceHistoryProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceHistory)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/services/add'),
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
                      l10n.serviceHistoryEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.serviceHistoryEmptyHint, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/services/add'),
                      child: Text(l10n.addService),
                    ),
                  ],
                ),
              ),
            );
          }

          final int totalSpend =
              records.fold<int>(0, (s, r) => s + r.totalCostPaisa);

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: records.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            children: [
                              Text('${records.length}'),
                              Text(l10n.totalServices),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Card(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            children: [
                              Text(currency.formatPaisa(totalSpend)),
                              Text(l10n.totalSpent),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              final ServiceRecord record = records[index - 1];
              return Card(
                child: ListTile(
                  title: Text(record.primaryItemTitle),
                  subtitle: Text(
                    [
                      MaterialLocalizations.of(context)
                          .formatMediumDate(record.serviceDate),
                      '${record.odometer} km',
                      if (record.vendorName != null) record.vendorName!,
                    ].join(' · '),
                  ),
                  trailing: Text(currency.formatPaisa(record.totalCostPaisa)),
                  onTap: () => context.push('/services/${record.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
