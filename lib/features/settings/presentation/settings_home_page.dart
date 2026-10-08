import 'package:flutter/material.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class SettingsHomePage extends StatelessWidget {
  const SettingsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _tile(
            context,
            Icons.tune_outlined,
            l10n.settingsGeneral,
            '/settings/general',
          ),
          _tile(
            context,
            Icons.palette_outlined,
            l10n.settingsAppearance,
            '/settings/appearance',
          ),
          _tile(
            context,
            Icons.notifications_outlined,
            l10n.settingsNotifications,
            '/settings/notifications',
          ),
          _tile(
            context,
            Icons.folder_outlined,
            l10n.settingsDataBackup,
            '/settings/data',
          ),
          _tile(
            context,
            Icons.lock_outline,
            l10n.settingsSecurity,
            '/settings/security',
          ),
          _tile(
            context,
            Icons.info_outline,
            l10n.settingsAbout,
            '/settings/about',
          ),
        ],
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
        minVerticalPadding: AppSpacing.sm,
        onTap: () => context.push(path),
      ),
    );
  }
}
