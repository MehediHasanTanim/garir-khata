import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAppearance)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.appearance, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(l10n.themeSystem),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(l10n.themeLight),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(l10n.themeDark),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (v) => controller.setThemeMode(v.first),
          ),
          const SizedBox(height: AppSpacing.lg),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.largerText),
            subtitle: Text(l10n.largerTextHint),
            value: settings.largerText,
            onChanged: controller.setLargerText,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.highContrast),
            subtitle: Text(l10n.highContrastHint),
            value: settings.highContrast,
            onChanged: controller.setHighContrast,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.appearancePreviewSample,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'গাড়ির খাতা — নমুনা বাংলা টেক্সট',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
