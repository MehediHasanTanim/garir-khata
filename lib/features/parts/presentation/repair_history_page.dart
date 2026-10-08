import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';
import 'package:garir_khata/features/parts/domain/repair_categories.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:go_router/go_router.dart';

class RepairHistoryPage extends ConsumerWidget {
  const RepairHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final history = ref.watch(selectedVehicleRepairHistoryProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.repairHistory)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/repairs/add'),
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
                      l10n.repairHistoryEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.repairHistoryEmptyHint,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/repairs/add'),
                      child: Text(l10n.addRepair),
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
                              Text(l10n.totalRepairs),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Card(
                        color: AppColors.repair.withValues(alpha: 0.08),
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
              final Repair record = records[index - 1];
              final category =
                  RepairCategories.byCode(record.category)?.localizedName(
                        languageCode,
                      ) ??
                  record.category;
              return Card(
                child: ListTile(
                  title: Text(record.problemDescription),
                  subtitle: Text(
                    [
                      category,
                      MaterialLocalizations.of(context)
                          .formatMediumDate(record.repairDate),
                      '${record.odometer} km',
                    ].join(' · '),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(currency.formatPaisa(record.totalCostPaisa)),
                      WarrantyBadge(state: record.warranty),
                    ],
                  ),
                  onTap: () => context.push('/repairs/${record.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
