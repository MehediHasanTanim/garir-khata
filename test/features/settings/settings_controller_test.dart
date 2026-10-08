import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
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
}
