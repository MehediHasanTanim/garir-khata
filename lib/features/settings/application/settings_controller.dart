import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/features/settings/application/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _localeKey = 'settings.locale';
const String _themeKey = 'settings.themeMode';
const String _selectedVehicleKey = 'settings.selectedVehicleId';
const String _onboardingKey = 'settings.onboardingCompleted';
const String _languageConfirmedKey = 'settings.languageConfirmed';

class SettingsController extends Notifier<AppSettings> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettings build() {
    final String languageCode = _prefs.getString(_localeKey) ?? 'en';
    final String themeName =
        _prefs.getString(_themeKey) ?? ThemeMode.system.name;
    final String? selectedVehicleId = _prefs.getString(_selectedVehicleKey);

    return AppSettings(
      locale: Locale(languageCode),
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => ThemeMode.system,
      ),
      selectedVehicleId: selectedVehicleId,
      onboardingCompleted: _prefs.getBool(_onboardingKey) ?? false,
      languageConfirmed: _prefs.getBool(_languageConfirmedKey) ?? false,
    );
  }

  Future<void> setLocale(Locale locale, {bool confirm = false}) async {
    await _prefs.setString(_localeKey, locale.languageCode);
    if (confirm) {
      await _prefs.setBool(_languageConfirmedKey, true);
    }
    state = state.copyWith(
      locale: locale,
      languageConfirmed: confirm ? true : null,
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeKey, themeMode.name);
    state = state.copyWith(themeMode: themeMode);
  }

  Future<void> setSelectedVehicleId(String? vehicleId) async {
    if (vehicleId == null) {
      await _prefs.remove(_selectedVehicleKey);
      state = state.copyWith(clearSelectedVehicleId: true);
      return;
    }
    await _prefs.setString(_selectedVehicleKey, vehicleId);
    state = state.copyWith(selectedVehicleId: vehicleId);
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingKey, true);
    state = state.copyWith(onboardingCompleted: true);
  }
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);
