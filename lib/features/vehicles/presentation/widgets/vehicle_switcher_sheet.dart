import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_type_icon.dart';
import 'package:go_router/go_router.dart';

Future<void> showVehicleSwitcher(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const VehicleSwitcherSheet(),
  );
}

class VehicleSwitcherSheet extends ConsumerWidget {
  const VehicleSwitcherSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vehiclesAsync = ref.watch(activeVehiclesProvider);
    final selectedId = ref.watch(selectedVehicleIdProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.selectVehicle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            vehiclesAsync.when(
              data: (vehicles) {
                if (vehicles.isEmpty) {
                  return Text(l10n.vehiclesEmpty);
                }
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height * 0.5,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: vehicles.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.xs),
                    itemBuilder: (context, index) {
                      final Vehicle vehicle = vehicles[index];
                      final bool selected = vehicle.id == selectedId;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                          side: BorderSide(
                            color: selected
                                ? AppColors.primary
                                : AppColors.divider,
                          ),
                        ),
                        leading: VehicleTypeBadge(
                          type: vehicle.vehicleType,
                          selected: selected,
                        ),
                        title: Text(vehicle.nickname),
                        subtitle: Text(
                          [
                            if (vehicle.displaySubtitle.isNotEmpty)
                              vehicle.displaySubtitle,
                            if (vehicle.registrationNumber != null)
                              vehicle.registrationNumber!,
                            '${vehicle.currentOdometer} km',
                          ].join(' · '),
                        ),
                        trailing: selected
                            ? const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                              )
                            : null,
                        onTap: () async {
                          await selectVehicle(ref, vehicle.id);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => Text(l10n.commonLoading),
              error: (_, _) => Text(l10n.commonError),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/vehicles/add');
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addNewVehicle),
            ),
          ],
        ),
      ),
    );
  }
}
