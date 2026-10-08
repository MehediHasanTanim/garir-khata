import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/features/settings/application/app_settings.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<ProviderContainer> createContainer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
  }

  test('defaults to English, system theme, incomplete onboarding', () async {
    final ProviderContainer container = await createContainer();
    addTearDown(container.dispose);

    final settings = container.read(settingsControllerProvider);
    expect(settings.locale.languageCode, 'en');
    expect(settings.themeMode, ThemeMode.system);
    expect(settings.onboardingCompleted, isFalse);
    expect(settings.languageConfirmed, isFalse);
  });

  test('language switching persists and can confirm', () async {
    final ProviderContainer container = await createContainer();
    addTearDown(container.dispose);

    await container
        .read(settingsControllerProvider.notifier)
        .setLocale(const Locale('bn'), confirm: true);

    final settings = container.read(settingsControllerProvider);
    expect(settings.locale.languageCode, 'bn');
    expect(settings.languageConfirmed, isTrue);
  });

  test('theme switching persists', () async {
    final ProviderContainer container = await createContainer();
    addTearDown(container.dispose);

    await container
        .read(settingsControllerProvider.notifier)
        .setThemeMode(ThemeMode.dark);

    expect(
      container.read(settingsControllerProvider).themeMode,
      ThemeMode.dark,
    );
  });

  test('completeOnboarding persists', () async {
    final ProviderContainer container = await createContainer();
    addTearDown(container.dispose);

    await container
        .read(settingsControllerProvider.notifier)
        .completeOnboarding();

    expect(
      container.read(settingsControllerProvider).onboardingCompleted,
      isTrue,
    );
  });

  test('MVP defaults for currency distance and fuel units', () async {
    final ProviderContainer container = await createContainer();
    addTearDown(container.dispose);

    final settings = container.read(settingsControllerProvider);
    expect(settings.currency.name, 'bdt');
    expect(settings.distanceUnit.name, 'km');
    expect(settings.fuelUnit.name, 'liter');
    expect(settings.autoLockTimeout.name, 'oneMinute');
    expect(settings.pinEnabled, isFalse);
  });

  test('notification and appearance prefs persist', () async {
    final ProviderContainer container = await createContainer();
    addTearDown(container.dispose);
    final controller = container.read(settingsControllerProvider.notifier);

    await controller.setLargerText(true);
    await controller.setHighContrast(true);
    await controller.setNotificationPreferences(
      const NotificationPreferences(
        maintenanceEnabled: false,
        documentsEnabled: true,
        backupReminderEnabled: true,
        advanceDays: 3,
        advanceKm: 100,
      ),
    );

    final settings = container.read(settingsControllerProvider);
    expect(settings.largerText, isTrue);
    expect(settings.highContrast, isTrue);
    expect(settings.notifications.maintenanceEnabled, isFalse);
    expect(settings.notifications.backupReminderEnabled, isTrue);
    expect(settings.notifications.advanceDays, 3);
    expect(settings.notifications.advanceKm, 100);
  });
}
