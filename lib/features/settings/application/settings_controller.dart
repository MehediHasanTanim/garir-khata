import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/features/settings/application/app_settings.dart';
import 'package:garir_khata/features/settings/data/secure_credentials_store.dart';
import 'package:garir_khata/features/settings/domain/preference_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _localeKey = 'settings.locale';
const String _themeKey = 'settings.themeMode';
const String _selectedVehicleKey = 'settings.selectedVehicleId';
const String _onboardingKey = 'settings.onboardingCompleted';
const String _languageConfirmedKey = 'settings.languageConfirmed';
const String _currencyKey = 'settings.currency';
const String _distanceKey = 'settings.distanceUnit';
const String _fuelUnitKey = 'settings.fuelUnit';
const String _dateFormatKey = 'settings.dateFormat';
const String _highContrastKey = 'settings.highContrast';
const String _largerTextKey = 'settings.largerText';
const String _notifMaintKey = 'settings.notif.maintenance';
const String _notifDocsKey = 'settings.notif.documents';
const String _notifBackupKey = 'settings.notif.backup';
const String _notifDaysKey = 'settings.notif.advanceDays';
const String _notifKmKey = 'settings.notif.advanceKm';
const String _pinEnabledKey = 'settings.pinEnabled';
const String _biometricsKey = 'settings.biometricsEnabled';
const String _autoLockKey = 'settings.autoLockTimeout';
const String _hidePreviewKey = 'settings.hideSensitivePreview';

final secureCredentialsStoreProvider = Provider<SecureCredentialsStore>((ref) {
  return SecureCredentialsStore();
});

class SettingsController extends Notifier<AppSettings> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettings build() {
    final String languageCode = _prefs.getString(_localeKey) ?? 'en';
    final String themeName =
        _prefs.getString(_themeKey) ?? ThemeMode.system.name;

    return AppSettings(
      locale: Locale(languageCode),
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => ThemeMode.system,
      ),
      selectedVehicleId: _prefs.getString(_selectedVehicleKey),
      onboardingCompleted: _prefs.getBool(_onboardingKey) ?? false,
      languageConfirmed: _prefs.getBool(_languageConfirmedKey) ?? false,
      currency: CurrencyCodeX.parse(_prefs.getString(_currencyKey) ?? 'bdt'),
      distanceUnit:
          DistanceUnitX.parse(_prefs.getString(_distanceKey) ?? 'km'),
      fuelUnit: FuelUnitX.parse(_prefs.getString(_fuelUnitKey) ?? 'liter'),
      dateFormat: DateFormatPreferenceX.parse(
        _prefs.getString(_dateFormatKey) ?? 'medium',
      ),
      highContrast: _prefs.getBool(_highContrastKey) ?? false,
      largerText: _prefs.getBool(_largerTextKey) ?? false,
      notifications: NotificationPreferences(
        maintenanceEnabled: _prefs.getBool(_notifMaintKey) ?? true,
        documentsEnabled: _prefs.getBool(_notifDocsKey) ?? true,
        backupReminderEnabled: _prefs.getBool(_notifBackupKey) ?? false,
        advanceDays: _prefs.getInt(_notifDaysKey) ?? 7,
        advanceKm: _prefs.getInt(_notifKmKey) ?? 200,
      ),
      pinEnabled: _prefs.getBool(_pinEnabledKey) ?? false,
      biometricsEnabled: _prefs.getBool(_biometricsKey) ?? false,
      autoLockTimeout:
          AutoLockTimeoutX.parse(_prefs.getString(_autoLockKey) ?? 'oneMinute'),
      hideSensitivePreview: _prefs.getBool(_hidePreviewKey) ?? true,
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

  Future<void> setCurrency(CurrencyCode currency) async {
    await _prefs.setString(_currencyKey, currency.name);
    state = state.copyWith(currency: currency);
  }

  Future<void> setDistanceUnit(DistanceUnit unit) async {
    await _prefs.setString(_distanceKey, unit.name);
    state = state.copyWith(distanceUnit: unit);
  }

  Future<void> setFuelUnit(FuelUnit unit) async {
    await _prefs.setString(_fuelUnitKey, unit.name);
    state = state.copyWith(fuelUnit: unit);
  }

  Future<void> setDateFormat(DateFormatPreference format) async {
    await _prefs.setString(_dateFormatKey, format.name);
    state = state.copyWith(dateFormat: format);
  }

  Future<void> setHighContrast(bool value) async {
    await _prefs.setBool(_highContrastKey, value);
    state = state.copyWith(highContrast: value);
  }

  Future<void> setLargerText(bool value) async {
    await _prefs.setBool(_largerTextKey, value);
    state = state.copyWith(largerText: value);
  }

  Future<void> setNotificationPreferences(
    NotificationPreferences prefs,
  ) async {
    await _prefs.setBool(_notifMaintKey, prefs.maintenanceEnabled);
    await _prefs.setBool(_notifDocsKey, prefs.documentsEnabled);
    await _prefs.setBool(_notifBackupKey, prefs.backupReminderEnabled);
    await _prefs.setInt(_notifDaysKey, prefs.advanceDays);
    await _prefs.setInt(_notifKmKey, prefs.advanceKm);
    state = state.copyWith(notifications: prefs);
  }

  Future<void> setPinEnabled(bool enabled) async {
    await _prefs.setBool(_pinEnabledKey, enabled);
    state = state.copyWith(pinEnabled: enabled);
  }

  Future<void> setBiometricsEnabled(bool enabled) async {
    await _prefs.setBool(_biometricsKey, enabled);
    state = state.copyWith(biometricsEnabled: enabled);
  }

  Future<void> setAutoLockTimeout(AutoLockTimeout timeout) async {
    await _prefs.setString(_autoLockKey, timeout.name);
    state = state.copyWith(autoLockTimeout: timeout);
  }

  Future<void> setHideSensitivePreview(bool value) async {
    await _prefs.setBool(_hidePreviewKey, value);
    state = state.copyWith(hideSensitivePreview: value);
  }
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);
