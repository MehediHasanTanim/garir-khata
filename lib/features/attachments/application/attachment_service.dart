import 'dart:typed_data';

import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/domain/entities/attachment.dart';
import 'package:garir_khata/features/attachments/domain/repositories/attachment_repository.dart';

class AttachmentService {
  AttachmentService({
    required this.repository,
    required this.storage,
    required this.uuidGenerator,
    required this.clock,
  });

  final AttachmentRepository repository;
  final FileStorageService storage;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<List<Attachment>>> list({
    required AttachmentOwnerType ownerType,
    required String ownerId,
  }) {
    return repository.listForOwner(ownerType: ownerType, ownerId: ownerId);
  }

  Future<Result<Attachment>> addBytes({
    required AttachmentOwnerType ownerType,
    required String ownerId,
    required Uint8List bytes,
    required String originalFileName,
    String? mimeType,
    String? displayLabel,
  }) async {
    final stored = await storage.storeBytes(
      bytes: bytes,
      originalFileName: originalFileName,
      ownerType: ownerType.code,
      mimeHint: mimeType,
    );
    if (stored case Failure(:final error)) {
      return Failure(error);
    }
    final file = (stored as Success<StoredFileResult>).data;
    final attachment = Attachment(
      id: uuidGenerator.v4(),
      ownerType: ownerType,
      ownerId: ownerId,
      originalFileName: originalFileName,
      storedFileName: file.storedFileName,
      mimeType: file.mimeType,
      fileSizeBytes: file.fileSizeBytes,
      relativePath: file.relativePath,
      thumbnailRelativePath: file.thumbnailRelativePath,
      checksumSha256: file.checksumSha256,
      displayLabel: displayLabel,
      createdAt: clock.now(),
    );
    return repository.create(attachment);
  }

  Future<Result<Attachment>> rename({
    required String id,
    required String displayLabel,
  }) async {
    final existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    final current = (existing as Success<Attachment?>).data;
    if (current == null) {
      return const Failure(NotFoundError(message: 'Attachment not found'));
    }
    return repository.update(current.copyWith(displayLabel: displayLabel));
  }

  Future<Result<void>> delete(String id) async {
    final existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    final current = (existing as Success<Attachment?>).data;
    if (current == null) {
      return const Failure(NotFoundError(message: 'Attachment not found'));
    }
    await storage.deleteRelative(current.relativePath);
    if (current.thumbnailRelativePath != null) {
      await storage.deleteRelative(current.thumbnailRelativePath!);
    }
    return repository.delete(id);
  }

  Future<bool> fileExists(Attachment attachment) {
    return storage.exists(attachment.relativePath);
  }
}
