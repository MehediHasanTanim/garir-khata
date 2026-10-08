import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/settings/domain/preference_enums.dart';

class GeneralSettingsPage extends ConsumerWidget {
  const GeneralSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsGeneral)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.language, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
              ButtonSegment(value: 'bn', label: Text(l10n.languageBangla)),
            ],
            selected: {settings.locale.languageCode},
            onSelectionChanged: (v) => controller.setLocale(Locale(v.first)),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.currency, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<CurrencyCode>(
            segments: const [
              ButtonSegment(value: CurrencyCode.bdt, label: Text('BDT')),
              ButtonSegment(value: CurrencyCode.usd, label: Text('USD')),
            ],
            selected: {settings.currency},
            onSelectionChanged: (v) => controller.setCurrency(v.first),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.distanceUnit, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<DistanceUnit>(
            segments: [
              ButtonSegment(value: DistanceUnit.km, label: Text(l10n.unitKm)),
              ButtonSegment(
                value: DistanceUnit.mile,
                label: Text(l10n.unitMile),
              ),
            ],
            selected: {settings.distanceUnit},
            onSelectionChanged: (v) => controller.setDistanceUnit(v.first),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.fuelUnit, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<FuelUnit>(
            segments: [
              ButtonSegment(
                value: FuelUnit.liter,
                label: Text(l10n.unitLiter),
              ),
              ButtonSegment(
                value: FuelUnit.gallon,
                label: Text(l10n.unitGallon),
              ),
            ],
            selected: {settings.fuelUnit},
            onSelectionChanged: (v) => controller.setFuelUnit(v.first),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.dateFormat, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<DateFormatPreference>(
            segments: [
              ButtonSegment(
                value: DateFormatPreference.short,
                label: Text(l10n.dateFormatShort),
              ),
              ButtonSegment(
                value: DateFormatPreference.medium,
                label: Text(l10n.dateFormatMedium),
              ),
              ButtonSegment(
                value: DateFormatPreference.long,
                label: Text(l10n.dateFormatLong),
              ),
            ],
            selected: {settings.dateFormat},
            onSelectionChanged: (v) => controller.setDateFormat(v.first),
          ),
        ],
      ),
    );
  }
}
