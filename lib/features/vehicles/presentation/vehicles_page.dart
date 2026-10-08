import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/archive_vehicle_dialog.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_type_icon.dart';
import 'package:go_router/go_router.dart';

class VehiclesPage extends ConsumerWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vehiclesAsync = ref.watch(activeVehiclesProvider);
    final selectedId = ref.watch(selectedVehicleIdProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myVehicles)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/vehicles/add'),
        icon: const Icon(Icons.add),
        label: Text(l10n.addVehicle),
      ),
      body: vehiclesAsync.when(
        data: (List<Vehicle> vehicles) {
          if (vehicles.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.vehiclesEmpty,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.vehiclesEmptyHint,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              88,
            ),
            itemCount: vehicles.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final Vehicle vehicle = vehicles[index];
              final bool selected = vehicle.id == selectedId;
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  onTap: () => context.push('/vehicles/${vehicle.id}'),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        VehicleTypeBadge(
                          type: vehicle.vehicleType,
                          selected: selected,
                          size: 52,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      vehicle.nickname,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  if (selected)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.xs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.12,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        l10n.active,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                              if (vehicle.displaySubtitle.isNotEmpty)
                                Text(vehicle.displaySubtitle),
                              Text(
                                [
                                  if (vehicle.registrationNumber != null)
                                    vehicle.registrationNumber!,
                                  '${vehicle.currentOdometer} km',
                                ].join(' · '),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            switch (value) {
                              case 'select':
                                await selectVehicle(ref, vehicle.id);
                              case 'edit':
                                if (context.mounted) {
                                  unawaited(
                                    context.push(
                                      '/vehicles/${vehicle.id}/edit',
                                    ),
                                  );
                                }
                              case 'archive':
                                final bool ok = await confirmArchiveVehicle(
                                  context,
                                );
                                if (ok) {
                                  await archiveSelectedVehicle(ref, vehicle.id);
                                }
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'select',
                              child: Text(l10n.select),
                            ),
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(l10n.commonEdit),
                            ),
                            PopupMenuItem(
                              value: 'archive',
                              child: Text(l10n.archive),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => Center(child: Text(l10n.commonLoading)),
        error: (_, _) => Center(child: Text(l10n.commonError)),
      ),
    );
  }
}
