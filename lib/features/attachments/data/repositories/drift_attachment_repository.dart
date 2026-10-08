import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/attachments/data/mappers/attachment_mapper.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/domain/entities/attachment.dart';
import 'package:garir_khata/features/attachments/domain/repositories/attachment_repository.dart';

class DriftAttachmentRepository implements AttachmentRepository {
  DriftAttachmentRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<Attachment>>> listForOwner({
    required AttachmentOwnerType ownerType,
    required String ownerId,
  }) async {
    try {
      final rows = await (_db.select(_db.attachments)
            ..where(
              (t) =>
                  t.ownerType.equals(ownerType.code) &
                  t.ownerId.equals(ownerId),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
      return Success(rows.map(AttachmentMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to list attachments', cause: error),
      );
    }
  }

  @override
  Future<Result<Attachment?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.attachments)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(row == null ? null : AttachmentMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load attachment', cause: error),
      );
    }
  }

  @override
  Future<Result<Attachment>> create(Attachment attachment) async {
    try {
      await _db
          .into(_db.attachments)
          .insert(AttachmentMapper.toCompanion(attachment));
      return Success(attachment);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save attachment', cause: error),
      );
    }
  }

  @override
  Future<Result<Attachment>> update(Attachment attachment) async {
    try {
      await (_db.update(_db.attachments)
            ..where((t) => t.id.equals(attachment.id)))
          .write(
        AttachmentsCompanion(
          displayLabel: Value(attachment.displayLabel),
          thumbnailRelativePath: Value(attachment.thumbnailRelativePath),
        ),
      );
      return Success(attachment);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update attachment', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.attachments)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete attachment', cause: error),
      );
    }
  }

  @override
  Future<Result<List<Attachment>>> listAll() async {
    try {
      final rows = await _db.select(_db.attachments).get();
      return Success(rows.map(AttachmentMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to list all attachments', cause: error),
      );
    }
  }
}
