import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/attachments/application/attachment_service.dart';
import 'package:garir_khata/features/attachments/data/repositories/drift_attachment_repository.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

void main() {
  late Directory temp;
  late AppDatabase db;
  late AttachmentService service;
  late FileStorageService storage;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('gk_attach_');
    db = AppDatabase(NativeDatabase.memory());
    storage = FileStorageService(
      rootDirectory: temp,
      uuidGenerator: const DefaultUuidGenerator(),
    );
    service = AttachmentService(
      repository: DriftAttachmentRepository(db),
      storage: storage,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
  });

  tearDown(() async {
    await db.close();
    if (await temp.exists()) {
      await temp.delete(recursive: true);
    }
  });

  Uint8List _pngBytes() {
    final image = img.Image(width: 32, height: 32);
    img.fill(image, color: img.ColorRgb8(10, 120, 80));
    return Uint8List.fromList(img.encodePng(image));
  }

  test('add and delete attachment stores and removes file', () async {
    final created = await service.addBytes(
      ownerType: AttachmentOwnerType.fuel,
      ownerId: 'fuel-1',
      bytes: _pngBytes(),
      originalFileName: 'receipt.png',
      mimeType: 'image/png',
    );
    expect(created.isSuccess, isTrue);
    final attachment = created.dataOrNull!;
    expect(await storage.exists(attachment.relativePath), isTrue);

    final listed = await service.list(
      ownerType: AttachmentOwnerType.fuel,
      ownerId: 'fuel-1',
    );
    expect(listed.dataOrNull, hasLength(1));

    final deleted = await service.delete(attachment.id);
    expect(deleted.isSuccess, isTrue);
    expect(await storage.exists(attachment.relativePath), isFalse);
  });

  test('missing file is detected', () async {
    final created = await service.addBytes(
      ownerType: AttachmentOwnerType.document,
      ownerId: 'doc-1',
      bytes: _pngBytes(),
      originalFileName: 'scan.png',
    );
    final attachment = created.dataOrNull!;
    await File(storage.absolutePath(attachment.relativePath)).delete();
    expect(await service.fileExists(attachment), isFalse);
  });

  test('temp cleanup removes old files', () async {
    await storage.ensureReady();
    final old = File(p.join(storage.tempRoot.path, 'old.bin'));
    await old.writeAsBytes([1, 2, 3]);
    await old.setLastModified(DateTime.now().subtract(const Duration(days: 2)));
    final deleted = await storage.cleanupTemp(
      olderThan: const Duration(hours: 1),
    );
    expect(deleted, greaterThanOrEqualTo(1));
  });
}
