import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_switcher_sheet.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_type_icon.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final selectedVehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          IconButton(
            tooltip: l10n.navMore,
            onPressed: () {},
            icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            selectedVehicle.when(
              data: (vehicle) {
                if (vehicle == null) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(l10n.selectedVehicleNone),
                    ),
                  );
                }
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    onTap: () => showVehicleSwitcher(context, ref),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          VehicleTypeBadge(
                            type: vehicle.vehicleType,
                            selected: true,
                            size: 52,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        vehicle.nickname,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.primary,
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
                        ],
                      ),
                    ),
                  ),
                );
              },
              loading: () => Text(l10n.commonLoading),
              error: (_, _) => Text(l10n.commonError),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.homePlaceholder,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
