import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/formatting/date_formatter.dart';
import 'package:garir_khata/core/formatting/distance_formatter.dart';
import 'package:garir_khata/core/formatting/odometer_formatter.dart';
import 'package:garir_khata/core/logging/app_logger.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in bootstrap',
  );
});

final appLoggerProvider = Provider<AppLogger>((ref) => AppLogger());

final clockProvider = Provider<Clock>((ref) => const SystemClock());

final uuidGeneratorProvider = Provider<UuidGenerator>(
  (ref) => const DefaultUuidGenerator(),
);

final currencyFormatterProvider = Provider<CurrencyFormatter>(
  (ref) => CurrencyFormatter(),
);

final dateFormatterProvider = Provider<DateFormatter>((ref) => DateFormatter());

final distanceFormatterProvider = Provider<DistanceFormatter>(
  (ref) => DistanceFormatter(),
);

final odometerFormatterProvider = Provider<OdometerFormatter>(
  (ref) => OdometerFormatter(),
);
