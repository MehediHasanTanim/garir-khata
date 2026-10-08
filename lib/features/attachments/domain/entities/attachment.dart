import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';

class Attachment {
  const Attachment({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.originalFileName,
    required this.storedFileName,
    required this.mimeType,
    required this.fileSizeBytes,
    required this.relativePath,
    required this.checksumSha256,
    required this.createdAt,
    this.thumbnailRelativePath,
    this.displayLabel,
  });

  final String id;
  final AttachmentOwnerType ownerType;
  final String ownerId;
  final String originalFileName;
  final String storedFileName;
  final String mimeType;
  final int fileSizeBytes;
  final String relativePath;
  final String? thumbnailRelativePath;
  final String checksumSha256;
  final String? displayLabel;
  final DateTime createdAt;

  String get label =>
      (displayLabel != null && displayLabel!.trim().isNotEmpty)
          ? displayLabel!.trim()
          : originalFileName;

  bool get isImage => mimeType.startsWith('image/');

  Attachment copyWith({
    String? displayLabel,
    String? thumbnailRelativePath,
  }) {
    return Attachment(
      id: id,
      ownerType: ownerType,
      ownerId: ownerId,
      originalFileName: originalFileName,
      storedFileName: storedFileName,
      mimeType: mimeType,
      fileSizeBytes: fileSizeBytes,
      relativePath: relativePath,
      checksumSha256: checksumSha256,
      createdAt: createdAt,
      thumbnailRelativePath:
          thumbnailRelativePath ?? this.thumbnailRelativePath,
      displayLabel: displayLabel ?? this.displayLabel,
    );
  }
}
