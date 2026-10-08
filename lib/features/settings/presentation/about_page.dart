import 'package:flutter/material.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';

/// Keep in sync with `pubspec.yaml` version.
const String kAppVersionLabel = '1.0.0+1';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAbout)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.appNameBangla,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(l10n.appName, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.appVersion),
            subtitle: const Text(kAppVersionLabel),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.privacyTitle),
            subtitle: Text(l10n.privacyBody),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.helpTitle),
            subtitle: Text(l10n.helpBody),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.openSourceLicenses),
            onTap: () => showLicensePage(
              context: context,
              applicationName: l10n.appName,
            ),
          ),
        ],
      ),
    );
  }
}
