import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:go_router/go_router.dart';

class BatteryOverviewPage extends ConsumerWidget {
  const BatteryOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final active = ref.watch(selectedVehicleActiveBatteryProvider);
    final history = ref.watch(selectedVehicleBatteryHistoryProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.batteryTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/batteries/add'),
        child: const Icon(Icons.add),
      ),
      body: active.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (battery) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                l10n.activeBattery,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (battery == null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        Text(l10n.batteryEmpty),
                        const SizedBox(height: AppSpacing.sm),
                        FilledButton(
                          onPressed: () => context.push('/batteries/add'),
                          child: Text(l10n.addBattery),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Card(
                  child: ListTile(
                    title: Text(battery.displayLabel),
                    subtitle: Text(
                      [
                        MaterialLocalizations.of(context)
                            .formatMediumDate(battery.installDate),
                        if (battery.installOdometer != null)
                          '${battery.installOdometer} km',
                        currency.formatPaisa(battery.costPaisa),
                      ].join(' · '),
                    ),
                    trailing: WarrantyBadge(state: battery.warranty),
                    onTap: () => context.push('/batteries/${battery.id}'),
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.batteryHistory,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              history.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => Text(l10n.commonError),
                data: (items) {
                  final past = items
                      .where((b) => b.status != BatteryStatus.active)
                      .toList();
                  if (past.isEmpty) {
                    return Text(l10n.batteryHistoryEmpty);
                  }
                  return Column(
                    children: past
                        .map(
                          (b) => Card(
                            child: ListTile(
                              title: Text(b.displayLabel),
                              subtitle: Text(
                                [
                                  b.status.name,
                                  MaterialLocalizations.of(context)
                                      .formatMediumDate(b.installDate),
                                ].join(' · '),
                              ),
                              onTap: () =>
                                  context.push('/batteries/${b.id}'),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
