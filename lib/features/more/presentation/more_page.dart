import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:go_router/go_router.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.moreTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
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
            leading: const Icon(Icons.speed_outlined),
            title: Text(l10n.odometerHistory),
            onTap: () => context.push('/odometer/history'),
          ),
          const Divider(),
          Text(l10n.language, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
              ButtonSegment(value: 'bn', label: Text(l10n.languageBangla)),
            ],
            selected: {settings.locale.languageCode},
            onSelectionChanged: (values) {
              controller.setLocale(Locale(values.first));
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.appearance, style: Theme.of(context).textTheme.titleMedium),
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
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (values) {
              controller.setThemeMode(values.first);
            },
          ),
        ],
      ),
    );
  }
}
