import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/logging/app_logger.dart';

/// Removes stale export/decrypt temp files from app-private storage.
class TempFileCleaner {
  TempFileCleaner({
    required this.storage,
    required this.logger,
  });

  final FileStorageService storage;
  final AppLogger logger;

  Future<int> cleanup({
    Duration olderThan = const Duration(hours: 12),
  }) async {
    try {
      final deleted = await storage.cleanupTemp(olderThan: olderThan);
      if (deleted > 0) {
        logger.info('Cleaned $deleted temporary file(s)');
      }
      return deleted;
    } on Object catch (error, stack) {
      logger.warning('Temp cleanup failed', error, stack);
      return 0;
    }
  }
}
