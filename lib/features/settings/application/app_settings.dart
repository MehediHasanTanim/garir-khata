import 'package:flutter/material.dart';
import 'package:garir_khata/features/settings/domain/preference_enums.dart';

class NotificationPreferences {
  const NotificationPreferences({
    this.maintenanceEnabled = true,
    this.documentsEnabled = true,
    this.backupReminderEnabled = false,
    this.advanceDays = 7,
    this.advanceKm = 200,
  });

  final bool maintenanceEnabled;
  final bool documentsEnabled;
  final bool backupReminderEnabled;
  final int advanceDays;
  final int advanceKm;

  NotificationPreferences copyWith({
    bool? maintenanceEnabled,
    bool? documentsEnabled,
    bool? backupReminderEnabled,
    int? advanceDays,
    int? advanceKm,
  }) {
    return NotificationPreferences(
      maintenanceEnabled: maintenanceEnabled ?? this.maintenanceEnabled,
      documentsEnabled: documentsEnabled ?? this.documentsEnabled,
      backupReminderEnabled:
          backupReminderEnabled ?? this.backupReminderEnabled,
      advanceDays: advanceDays ?? this.advanceDays,
      advanceKm: advanceKm ?? this.advanceKm,
    );
  }
}

class AppSettings {
  const AppSettings({
    this.locale = const Locale('en'),
    this.themeMode = ThemeMode.system,
    this.selectedVehicleId,
    this.onboardingCompleted = false,
    this.languageConfirmed = false,
    this.currency = CurrencyCode.bdt,
    this.distanceUnit = DistanceUnit.km,
    this.fuelUnit = FuelUnit.liter,
    this.dateFormat = DateFormatPreference.medium,
    this.highContrast = false,
    this.largerText = false,
    this.notifications = const NotificationPreferences(),
    this.pinEnabled = false,
    this.biometricsEnabled = false,
    this.autoLockTimeout = AutoLockTimeout.oneMinute,
    this.hideSensitivePreview = true,
  });

  final Locale locale;
  final ThemeMode themeMode;
  final String? selectedVehicleId;
  final bool onboardingCompleted;
  final bool languageConfirmed;
  final CurrencyCode currency;
  final DistanceUnit distanceUnit;
  final FuelUnit fuelUnit;
  final DateFormatPreference dateFormat;
  final bool highContrast;
  final bool largerText;
  final NotificationPreferences notifications;
  final bool pinEnabled;
  final bool biometricsEnabled;
  final AutoLockTimeout autoLockTimeout;
  final bool hideSensitivePreview;

  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    String? selectedVehicleId,
    bool clearSelectedVehicleId = false,
    bool? onboardingCompleted,
    bool? languageConfirmed,
    CurrencyCode? currency,
    DistanceUnit? distanceUnit,
    FuelUnit? fuelUnit,
    DateFormatPreference? dateFormat,
    bool? highContrast,
    bool? largerText,
    NotificationPreferences? notifications,
    bool? pinEnabled,
    bool? biometricsEnabled,
    AutoLockTimeout? autoLockTimeout,
    bool? hideSensitivePreview,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      selectedVehicleId: clearSelectedVehicleId
          ? null
          : (selectedVehicleId ?? this.selectedVehicleId),
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      languageConfirmed: languageConfirmed ?? this.languageConfirmed,
      currency: currency ?? this.currency,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      fuelUnit: fuelUnit ?? this.fuelUnit,
      dateFormat: dateFormat ?? this.dateFormat,
      highContrast: highContrast ?? this.highContrast,
      largerText: largerText ?? this.largerText,
      notifications: notifications ?? this.notifications,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      autoLockTimeout: autoLockTimeout ?? this.autoLockTimeout,
      hideSensitivePreview:
          hideSensitivePreview ?? this.hideSensitivePreview,
    );
  }
}
