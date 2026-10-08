import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/odometer/application/odometer_providers.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

class OdometerHistoryPage extends ConsumerWidget {
  const OdometerHistoryPage({super.key});

  String _sourceLabel(AppLocalizations l10n, OdometerSourceType type) {
    return switch (type) {
      OdometerSourceType.manual => l10n.odometerSourceManual,
      OdometerSourceType.fuel => l10n.odometerSourceFuel,
      OdometerSourceType.service => l10n.odometerSourceService,
      OdometerSourceType.repair => l10n.odometerSourceRepair,
      OdometerSourceType.oilChange => l10n.odometerSourceOil,
      OdometerSourceType.reset => l10n.odometerSourceReset,
      OdometerSourceType.import => l10n.odometerSourceImport,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(selectedVehicleOdometerHistoryProvider);
    final vehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.odometerHistory)),
      body: history.when(
        data: (entries) {
          if (entries.isEmpty) {
            return Center(child: Text(l10n.odometerHistoryEmpty));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, index) {
              final OdometerEntry entry = entries[index];
              final int? previous =
                  index + 1 < entries.length ? entries[index + 1].odometer : null;
              final int? diff =
                  previous == null ? null : entry.odometer - previous;
              return Card(
                child: ListTile(
                  leading: Icon(
                    entry.isDiscontinuity
                        ? Icons.restart_alt
                        : Icons.speed_outlined,
                  ),
                  title: Text('${entry.odometer} km'),
                  subtitle: Text(
                    [
                      _sourceLabel(l10n, entry.sourceType),
                      MaterialLocalizations.of(context)
                          .formatMediumDate(entry.recordedAt),
                      if (diff != null) '${diff >= 0 ? '+' : ''}$diff km',
                    ].join(' · '),
                  ),
                ),
              );
            },
          );
        },
        loading: () => Center(child: Text(l10n.commonLoading)),
        error: (_, _) => Center(child: Text(l10n.commonError)),
      ),
      bottomNavigationBar: vehicle.when(
        data: (v) => v == null
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    '${v.nickname} · ${v.currentOdometer} km',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        loading: () => null,
        error: (_, _) => null,
      ),
    );
  }
}
