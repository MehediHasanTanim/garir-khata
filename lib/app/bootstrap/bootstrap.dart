import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/app.dart';
import 'package:garir_khata/core/files/app_storage_paths.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/logging/app_logger.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/security/temp_file_cleaner.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final AppLogger logger = AppLogger();
  logger.info('Garir Khata bootstrap started');

  // Best-effort cleanup of decrypted export/restore temp files.
  try {
    final root = await AppStoragePaths.filesRoot();
    await root.create(recursive: true);
    await TempFileCleaner(
      storage: FileStorageService(
        rootDirectory: root,
        uuidGenerator: const DefaultUuidGenerator(),
      ),
      logger: logger,
    ).cleanup();
  } on Object catch (error, stack) {
    logger.warning('Bootstrap temp cleanup skipped', error, stack);
  }

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
