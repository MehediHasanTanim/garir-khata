import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/documents/data/mappers/document_mapper.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';
import 'package:garir_khata/features/documents/domain/repositories/document_repository.dart';

class DriftDocumentRepository implements DocumentRepository {
  DriftDocumentRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<VehicleDocument>>> getForVehicle(String vehicleId) async {
    try {
      final rows = await (_db.select(_db.vehicleDocuments)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.asc(t.expiryDate)]))
          .get();
      return Success(rows.map(DocumentMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load documents', cause: error),
      );
    }
  }

  @override
  Future<Result<List<VehicleDocument>>> getExpiring({
    required String vehicleId,
    required DateTime before,
  }) async {
    try {
      final rows = await (_db.select(_db.vehicleDocuments)
            ..where(
              (t) =>
                  t.vehicleId.equals(vehicleId) &
                  t.expiryDate.isNotNull() &
                  t.expiryDate.isSmallerOrEqualValue(before),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.expiryDate)]))
          .get();
      return Success(rows.map(DocumentMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load expiring documents', cause: error),
      );
    }
  }

  @override
  Future<Result<VehicleDocument?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.vehicleDocuments)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(row == null ? null : DocumentMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load document', cause: error),
      );
    }
  }

  @override
  Future<Result<VehicleDocument>> create(VehicleDocument document) async {
    try {
      await _db
          .into(_db.vehicleDocuments)
          .insert(DocumentMapper.toCompanion(document));
      return Success(document);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save document', cause: error),
      );
    }
  }

  @override
  Future<Result<VehicleDocument>> update(VehicleDocument document) async {
    try {
      await _db
          .into(_db.vehicleDocuments)
          .insertOnConflictUpdate(DocumentMapper.toCompanion(document));
      return Success(document);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update document', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.vehicleDocuments)..where((t) => t.id.equals(id)))
          .go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete document', cause: error),
      );
    }
  }
}
