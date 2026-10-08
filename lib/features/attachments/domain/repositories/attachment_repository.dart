import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/domain/entities/attachment.dart';

abstract interface class AttachmentRepository {
  Future<Result<List<Attachment>>> listForOwner({
    required AttachmentOwnerType ownerType,
    required String ownerId,
  });

  Future<Result<Attachment?>> getById(String id);

  Future<Result<Attachment>> create(Attachment attachment);

  Future<Result<Attachment>> update(Attachment attachment);

  Future<Result<void>> delete(String id);

  Future<Result<List<Attachment>>> listAll();
}
