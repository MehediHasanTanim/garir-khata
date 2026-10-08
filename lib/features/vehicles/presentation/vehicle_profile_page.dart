import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/archive_vehicle_dialog.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_labels.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_type_icon.dart';
import 'package:go_router/go_router.dart';

class VehicleProfilePage extends ConsumerWidget {
  const VehicleProfilePage({required this.vehicleId, super.key});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vehicleAsync = ref.watch(vehicleByIdProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.vehicleProfile),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/vehicles/$vehicleId/edit'),
          ),
        ],
      ),
      body: vehicleAsync.when(
        data: (Vehicle? vehicle) {
          if (vehicle == null || vehicle.isArchived) {
            return Center(child: Text(l10n.commonError));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Row(
                children: [
                  VehicleTypeBadge(type: vehicle.vehicleType, size: 64),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.nickname,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(vehicleTypeLabel(context, vehicle.vehicleType)),
                        if (vehicle.registrationNumber != null)
                          Text(vehicle.registrationNumber!),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _Section(
                title: l10n.overviewSection,
                children: [
                  _Row(
                    l10n.fieldFuelType,
                    fuelTypeLabel(context, vehicle.fuelType),
                  ),
                  _Row(
                    l10n.fieldCurrentOdometer,
                    '${vehicle.currentOdometer} km',
                  ),
                  if (vehicle.displaySubtitle.isNotEmpty)
                    _Row(l10n.fieldBrandModel, vehicle.displaySubtitle),
                  if (vehicle.modelYear != null)
                    _Row(l10n.fieldModelYear, '${vehicle.modelYear}'),
                ],
              ),
              _Section(
                title: l10n.technicalSection,
                children: [
                  if (vehicle.engineCapacity != null)
                    _Row(l10n.fieldEngineCapacity, vehicle.engineCapacity!),
                  if (vehicle.engineNumber != null)
                    _Row(l10n.fieldEngineNumber, vehicle.engineNumber!),
                  if (vehicle.chassisNumber != null)
                    _Row(l10n.fieldChassisNumber, vehicle.chassisNumber!),
                  if (vehicle.color != null)
                    _Row(l10n.fieldColor, vehicle.color!),
                ],
              ),
              _Section(
                title: l10n.ownershipSection,
                children: [
                  if (vehicle.ownershipType != null)
                    _Row(
                      l10n.fieldOwnership,
                      ownershipTypeLabel(context, vehicle.ownershipType!),
                    ),
                  if (vehicle.purchaseDate != null)
                    _Row(
                      l10n.fieldPurchaseDate,
                      MaterialLocalizations.of(context)
                          .formatMediumDate(vehicle.purchaseDate!),
                    ),
                  if (vehicle.purchasePricePaisa != null)
                    _Row(
                      l10n.fieldPurchasePrice,
                      '৳ ${(vehicle.purchasePricePaisa! / 100).toStringAsFixed(0)}',
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: () async {
                  final bool ok = await confirmArchiveVehicle(context);
                  if (!ok) {
                    return;
                  }
                  final result = await archiveSelectedVehicle(ref, vehicleId);
                  if (context.mounted && result.isSuccess) {
                    context.go('/vehicles');
                  }
                },
                child: Text(l10n.archiveVehicle),
              ),
            ],
          );
        },
        loading: () => Center(child: Text(l10n.commonLoading)),
        error: (_, _) => Center(child: Text(l10n.commonError)),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
