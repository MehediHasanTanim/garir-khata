import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/files/app_storage_paths.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/attachments/application/attachment_service.dart';
import 'package:garir_khata/features/attachments/application/media_picker.dart';
import 'package:garir_khata/features/attachments/data/repositories/drift_attachment_repository.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/domain/entities/attachment.dart';
import 'package:garir_khata/features/attachments/domain/repositories/attachment_repository.dart';

final fileStorageRootProvider = FutureProvider<Directory>((ref) async {
  final dir = await AppStoragePaths.filesRoot();
  await dir.create(recursive: true);
  return dir;
});

final fileStorageServiceProvider = Provider<FileStorageService>((ref) {
  // Synchronous fallback for tests that override this provider.
  final asyncRoot = ref.watch(fileStorageRootProvider);
  final root = asyncRoot.value ?? Directory.systemTemp;
  return FileStorageService(
    rootDirectory: root,
    uuidGenerator: const DefaultUuidGenerator(),
  );
});

final attachmentRepositoryProvider = Provider<AttachmentRepository>((ref) {
  return DriftAttachmentRepository(ref.watch(appDatabaseProvider));
});

final mediaPickerProvider = Provider<MediaPicker>((ref) => MediaPicker());

final attachmentServiceProvider = Provider<AttachmentService>((ref) {
  return AttachmentService(
    repository: ref.watch(attachmentRepositoryProvider),
    storage: ref.watch(fileStorageServiceProvider),
    uuidGenerator: const DefaultUuidGenerator(),
    clock: const SystemClock(),
  );
});

final attachmentsForOwnerProvider = FutureProvider.family<List<Attachment>,
    ({AttachmentOwnerType type, String ownerId})>((ref, key) async {
  final result = await ref.watch(attachmentServiceProvider).list(
        ownerType: key.type,
        ownerId: key.ownerId,
      );
  return result.when(success: (v) => v, failure: (e) => throw e);
});
