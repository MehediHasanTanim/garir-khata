import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.moreTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(l10n.settingsTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.directions_car_outlined),
            title: Text(l10n.vehicles),
            onTap: () => context.push('/vehicles'),
          ),
          ListTile(
            leading: const Icon(Icons.local_gas_station_outlined),
            title: Text(l10n.fuelHistory),
            onTap: () => context.push('/fuel'),
          ),
          ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: Text(l10n.expenseHistory),
            onTap: () => context.push('/expenses'),
          ),
          ListTile(
            leading: const Icon(Icons.build_outlined),
            title: Text(l10n.serviceHistory),
            onTap: () => context.push('/services'),
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: Text(l10n.oilHistory),
            onTap: () => context.push('/oil'),
          ),
          ListTile(
            leading: const Icon(Icons.handyman_outlined),
            title: Text(l10n.repairHistory),
            onTap: () => context.push('/repairs'),
          ),
          ListTile(
            leading: const Icon(Icons.extension_outlined),
            title: Text(l10n.vehicleParts),
            onTap: () => context.push('/parts'),
          ),
          ListTile(
            leading: const Icon(Icons.trip_origin),
            title: Text(l10n.tyresTitle),
            onTap: () => context.push('/tyres'),
          ),
          ListTile(
            leading: const Icon(Icons.battery_charging_full_outlined),
            title: Text(l10n.batteryTitle),
            onTap: () => context.push('/batteries'),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.documentsTitle),
            onTap: () => context.push('/documents'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(l10n.remindersTitle),
            onTap: () => context.push('/reminders'),
          ),
          ListTile(
            leading: const Icon(Icons.speed_outlined),
            title: Text(l10n.odometerHistory),
            onTap: () => context.push('/odometer/history'),
          ),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: Text(l10n.exportDataTitle),
            onTap: () => context.push('/export'),
          ),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: Text(l10n.backupRestoreTitle),
            onTap: () => context.push('/backup'),
          ),
        ],
      ),
    );
  }
}
