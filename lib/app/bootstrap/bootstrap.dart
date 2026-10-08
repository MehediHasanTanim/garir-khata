import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/app.dart';
import 'package:garir_khata/core/logging/app_logger.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final AppLogger logger = AppLogger();
  logger.info('Garir Khata bootstrap started');

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appLoggerProvider.overrideWithValue(logger),
      ],
      child: const GarirKhataApp(),
    ),
  );
}
