import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportsTitle)),
      body: vehicle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (v) {
          if (v == null) {
            return Center(child: Text(l10n.selectedVehicleNone));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                v.nickname,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              _tile(
                context,
                Icons.calendar_month_outlined,
                l10n.monthlyExpenseReport,
                '/reports/monthly',
              ),
              _tile(
                context,
                Icons.insights_outlined,
                l10n.yearlyExpenseReport,
                '/reports/yearly',
              ),
              _tile(
                context,
                Icons.local_gas_station_outlined,
                l10n.fuelReport,
                '/reports/fuel',
              ),
              _tile(
                context,
                Icons.speed_outlined,
                l10n.mileageReport,
                '/reports/mileage',
              ),
              _tile(
                context,
                Icons.calculate_outlined,
                l10n.costPerKmReport,
                '/reports/cost-per-km',
              ),
              _tile(
                context,
                Icons.build_outlined,
                l10n.maintenanceReport,
                '/reports/maintenance',
              ),
              _tile(
                context,
                Icons.handyman_outlined,
                l10n.repairReport,
                '/reports/repair',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String path,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(path),
      ),
    );
  }
}
