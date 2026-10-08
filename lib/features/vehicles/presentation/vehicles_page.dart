import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

/// Example feature screen proving architecture layers with no direct DB access.
class VehiclesPage extends ConsumerWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vehiclesAsync = ref.watch(activeVehiclesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.vehiclesExampleTitle)),
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
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: vehicles.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final Vehicle vehicle = vehicles[index];
              return Card(
                child: ListTile(
                  title: Text(vehicle.nickname),
                  subtitle: Text(
                    [
                      if (vehicle.brand != null) vehicle.brand,
                      if (vehicle.model != null) vehicle.model,
                      '${vehicle.currentOdometer} km',
                    ].whereType<String>().join(' · '),
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
