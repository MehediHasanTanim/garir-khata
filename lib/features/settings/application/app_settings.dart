import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    this.locale = const Locale('en'),
    this.themeMode = ThemeMode.system,
    this.selectedVehicleId,
    this.onboardingCompleted = false,
    this.languageConfirmed = false,
  });

  final Locale locale;
  final ThemeMode themeMode;
  final String? selectedVehicleId;
  final bool onboardingCompleted;
  final bool languageConfirmed;

  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    String? selectedVehicleId,
    bool clearSelectedVehicleId = false,
    bool? onboardingCompleted,
    bool? languageConfirmed,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      selectedVehicleId: clearSelectedVehicleId
          ? null
          : (selectedVehicleId ?? this.selectedVehicleId),
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      languageConfirmed: languageConfirmed ?? this.languageConfirmed,
    );
  }
}
