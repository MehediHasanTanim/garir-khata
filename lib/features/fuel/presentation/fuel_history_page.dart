import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/fuel/application/fuel_providers.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_switcher_sheet.dart';
import 'package:go_router/go_router.dart';

class FuelHistoryPage extends ConsumerWidget {
  const FuelHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(selectedVehicleFuelHistoryProvider);
    final vehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fuelHistory),
        actions: [
          IconButton(
            onPressed: () => showVehicleSwitcher(context, ref),
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/fuel/add'),
        child: const Icon(Icons.add),
      ),
      body: history.when(
        data: (entries) {
          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.fuelHistoryEmpty,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.fuelHistoryEmptyHint,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/fuel/add'),
                      child: Text(l10n.addFuel),
                    ),
                  ],
                ),
              ),
            );
          }

          final int totalPaisa =
              entries.fold<int>(0, (sum, e) => sum + e.totalCostPaisa);
          final int totalMl =
              entries.fold<int>(0, (sum, e) => sum + e.quantityMl);

          return RefreshIndicator(
            onRefresh: () async {
              final v = await ref.read(selectedVehicleProvider.future);
              if (v != null) {
                ref.invalidate(fuelHistoryProvider(v.id));
              }
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                88,
              ),
              children: [
                vehicle.when(
                  data: (v) => Text(
                    v?.nickname ?? l10n.selectedVehicleNone,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Expanded(
                          child: _Summary(
                            label: l10n.totalFuelSpend,
                            value: '৳ ${(totalPaisa / 100).toStringAsFixed(0)}',
                          ),
                        ),
                        Expanded(
                          child: _Summary(
                            label: l10n.totalLiters,
                            value: '${(totalMl / 1000).toStringAsFixed(1)} L',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                for (final FuelEntry entry in entries) ...[
                  Card(
                    child: ListTile(
                      onTap: () => context.push('/fuel/${entry.id}'),
                      title: Text(
                        '৳ ${entry.totalCostMajor.toStringAsFixed(0)} · '
                        '${entry.quantityLiters.toStringAsFixed(1)} L',
                      ),
                      subtitle: Text(
                        [
                          MaterialLocalizations.of(context)
                              .formatMediumDate(entry.dateTime),
                          '${entry.odometer} km',
                          if (entry.isFullTank) l10n.fullTankBadge,
                        ].join(' · '),
                      ),
                      trailing: entry.isFullTank
                          ? const Icon(
                              Icons.local_gas_station,
                              color: AppColors.primary,
                            )
                          : const Icon(Icons.chevron_right),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                ],
              ],
            ),
          );
        },
        loading: () => Center(child: Text(l10n.commonLoading)),
        error: (_, _) => Center(child: Text(l10n.commonError)),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(value, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
