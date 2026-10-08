import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/logging/app_logger.dart';
import 'package:garir_khata/core/security/temp_file_cleaner.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory temp;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('gk_temp_clean_');
  });

  tearDown(() async {
    if (await temp.exists()) {
      await temp.delete(recursive: true);
    }
  });

  test('cleanup removes stale temp files', () async {
    final storage = FileStorageService(
      rootDirectory: temp,
      uuidGenerator: const DefaultUuidGenerator(),
    );
    await storage.ensureReady();
    final tempDir = Directory(p.join(temp.path, 'tmp'));
    await tempDir.create(recursive: true);
    final stale = File(p.join(tempDir.path, 'old.bin'));
    await stale.writeAsString('x');
    await stale.setLastModified(
      DateTime.now().subtract(const Duration(days: 2)),
    );

    final deleted = await TempFileCleaner(
      storage: storage,
      logger: AppLogger(),
    ).cleanup(olderThan: const Duration(hours: 1));

    expect(deleted, greaterThanOrEqualTo(1));
    expect(await stale.exists(), isFalse);
  });
}
