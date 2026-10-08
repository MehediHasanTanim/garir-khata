import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class TyreOverviewPage extends ConsumerWidget {
  const TyreOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final tyres = ref.watch(selectedVehicleActiveTyresProvider);
    final vehicleAsync = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tyresTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tyres/add'),
        child: const Icon(Icons.add),
      ),
      body: tyres.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (items) {
          final vehicle = vehicleAsync.value;
          final positions = vehicle == null
              ? const <TyrePosition>[]
              : TyrePositionRules.forVehicleType(vehicle.vehicleType);

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.tyresEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.tyresEmptyHint, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/tyres/add'),
                      child: Text(l10n.addTyre),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (positions.isNotEmpty) ...[
                Text(
                  l10n.tyrePositions,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: positions.map((pos) {
                    final Tyre? match = items
                        .where((t) => t.position == pos)
                        .firstOrNull;
                    final label = languageCode == 'bn'
                        ? TyrePositionRules.labelBn(pos)
                        : TyrePositionRules.labelEn(pos);
                    return ActionChip(
                      label: Text(
                        match == null ? label : '$label · ${match.displayLabel}',
                      ),
                      onPressed: match == null
                          ? () => context.push('/tyres/add?position=${pos.name}')
                          : () => context.push('/tyres/${match.id}'),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              Text(
                l10n.activeTyres,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              ...items.map((tyre) {
                final posLabel = languageCode == 'bn'
                    ? TyrePositionRules.labelBn(tyre.position)
                    : TyrePositionRules.labelEn(tyre.position);
                return Card(
                  child: ListTile(
                    title: Text(tyre.displayLabel),
                    subtitle: Text(
                      [
                        posLabel,
                        MaterialLocalizations.of(context)
                            .formatMediumDate(tyre.installDate),
                        '${tyre.installOdometer} km',
                      ].join(' · '),
                    ),
                    trailing: WarrantyBadge(state: tyre.warranty),
                    onTap: () => context.push('/tyres/${tyre.id}'),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
