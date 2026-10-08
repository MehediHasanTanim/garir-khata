import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);
    final prefs = settings.notifications;
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsNotifications)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          FutureBuilder<PermissionStatus>(
            future: Permission.notification.status,
            builder: (context, snap) {
              final status = snap.data;
              final denied = status?.isDenied == true ||
                  status?.isPermanentlyDenied == true;
              if (!denied) {
                return const SizedBox.shrink();
              }
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.notifications_off_outlined),
                  title: Text(l10n.notificationPermissionDenied),
                  trailing: TextButton(
                    onPressed: openAppSettings,
                    child: Text(l10n.openSystemSettings),
                  ),
                ),
              );
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.notifMaintenance),
            value: prefs.maintenanceEnabled,
            onChanged: (v) => controller.setNotificationPreferences(
              prefs.copyWith(maintenanceEnabled: v),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.notifDocuments),
            value: prefs.documentsEnabled,
            onChanged: (v) => controller.setNotificationPreferences(
              prefs.copyWith(documentsEnabled: v),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.notifBackupReminder),
            value: prefs.backupReminderEnabled,
            onChanged: (v) => controller.setNotificationPreferences(
              prefs.copyWith(backupReminderEnabled: v),
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldAdvanceDays),
            subtitle: Text('${prefs.advanceDays}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: l10n.commonDecrease,
                  onPressed: prefs.advanceDays <= 1
                      ? null
                      : () => controller.setNotificationPreferences(
                            prefs.copyWith(advanceDays: prefs.advanceDays - 1),
                          ),
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  tooltip: l10n.commonIncrease,
                  onPressed: () => controller.setNotificationPreferences(
                    prefs.copyWith(advanceDays: prefs.advanceDays + 1),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldAdvanceKm),
            subtitle: Text('${prefs.advanceKm}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: l10n.commonDecrease,
                  onPressed: prefs.advanceKm <= 50
                      ? null
                      : () => controller.setNotificationPreferences(
                            prefs.copyWith(advanceKm: prefs.advanceKm - 50),
                          ),
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  tooltip: l10n.commonIncrease,
                  onPressed: () => controller.setNotificationPreferences(
                    prefs.copyWith(advanceKm: prefs.advanceKm + 50),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
