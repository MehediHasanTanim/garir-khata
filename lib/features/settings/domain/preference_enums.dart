enum CurrencyCode { bdt, usd }

enum DistanceUnit { km, mile }

enum FuelUnit { liter, gallon }

enum DateFormatPreference { medium, long, short }

enum AutoLockTimeout {
  immediately,
  thirtySeconds,
  oneMinute,
  fiveMinutes,
  never,
}

extension CurrencyCodeX on CurrencyCode {
  String get code => name.toUpperCase();
  static CurrencyCode parse(String raw) => CurrencyCode.values.firstWhere(
        (e) => e.name == raw.toLowerCase() || e.code == raw.toUpperCase(),
        orElse: () => CurrencyCode.bdt,
      );
}

extension DistanceUnitX on DistanceUnit {
  String get code => name;
  static DistanceUnit parse(String raw) => DistanceUnit.values.firstWhere(
        (e) => e.name == raw,
        orElse: () => DistanceUnit.km,
      );
}

extension FuelUnitX on FuelUnit {
  String get code => name;
  static FuelUnit parse(String raw) => FuelUnit.values.firstWhere(
        (e) => e.name == raw,
        orElse: () => FuelUnit.liter,
      );
}

extension DateFormatPreferenceX on DateFormatPreference {
  String get code => name;
  static DateFormatPreference parse(String raw) =>
      DateFormatPreference.values.firstWhere(
        (e) => e.name == raw,
        orElse: () => DateFormatPreference.medium,
      );
}

extension AutoLockTimeoutX on AutoLockTimeout {
  String get code => name;

  Duration? get duration => switch (this) {
        AutoLockTimeout.immediately => Duration.zero,
        AutoLockTimeout.thirtySeconds => const Duration(seconds: 30),
        AutoLockTimeout.oneMinute => const Duration(minutes: 1),
        AutoLockTimeout.fiveMinutes => const Duration(minutes: 5),
        AutoLockTimeout.never => null,
      };

  static AutoLockTimeout parse(String raw) => AutoLockTimeout.values.firstWhere(
        (e) => e.name == raw,
        orElse: () => AutoLockTimeout.oneMinute,
      );
}
