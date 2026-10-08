import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/domain/entities/attachment.dart';

abstract final class AttachmentMapper {
  static Attachment toDomain(AttachmentRow row) {
    return Attachment(
      id: row.id,
      ownerType: AttachmentOwnerTypeX.tryParse(row.ownerType) ??
          AttachmentOwnerType.note,
      ownerId: row.ownerId,
      originalFileName: row.originalFileName,
      storedFileName: row.storedFileName,
      mimeType: row.mimeType,
      fileSizeBytes: row.fileSizeBytes,
      relativePath: row.relativePath,
      thumbnailRelativePath: row.thumbnailRelativePath,
      checksumSha256: row.checksumSha256,
      displayLabel: row.displayLabel,
      createdAt: row.createdAt,
    );
  }

  static AttachmentsCompanion toCompanion(Attachment entity) {
    return AttachmentsCompanion.insert(
      id: entity.id,
      ownerType: entity.ownerType.code,
      ownerId: entity.ownerId,
      originalFileName: entity.originalFileName,
      storedFileName: entity.storedFileName,
      mimeType: entity.mimeType,
      fileSizeBytes: entity.fileSizeBytes,
      relativePath: entity.relativePath,
      thumbnailRelativePath: Value(entity.thumbnailRelativePath),
      checksumSha256: entity.checksumSha256,
      displayLabel: Value(entity.displayLabel),
      createdAt: entity.createdAt,
    );
  }
}
