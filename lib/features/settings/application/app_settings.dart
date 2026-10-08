import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    this.locale = const Locale('en'),
    this.themeMode = ThemeMode.system,
    this.selectedVehicleId,
  });

  final Locale locale;
  final ThemeMode themeMode;
  final String? selectedVehicleId;

  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    String? selectedVehicleId,
    bool clearSelectedVehicleId = false,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      selectedVehicleId: clearSelectedVehicleId
          ? null
          : (selectedVehicleId ?? this.selectedVehicleId),
    );
  }
}
