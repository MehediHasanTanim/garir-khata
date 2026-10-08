import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/data/mappers/parts_mapper.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';
import 'package:garir_khata/features/parts/domain/repositories/vehicle_part_repository.dart';

class DriftVehiclePartRepository implements VehiclePartRepository {
  DriftVehiclePartRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<VehiclePart>>> getActive(String vehicleId) async {
    try {
      final rows = await (_db.select(_db.vehicleParts)
            ..where(
              (t) => t.vehicleId.equals(vehicleId) & t.isActive.equals(true),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.installedDate)]))
          .get();
      return Success(rows.map(PartsMapper.vehiclePartToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load parts', cause: error),
      );
    }
  }

  @override
  Future<Result<VehiclePart?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.vehicleParts)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(
        row == null ? null : PartsMapper.vehiclePartToDomain(row),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load part', cause: error),
      );
    }
  }

  @override
  Future<Result<VehiclePart>> create(VehiclePart part) async {
    try {
      await _db
          .into(_db.vehicleParts)
          .insert(PartsMapper.vehiclePartCompanion(part));
      return Success(part);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save part', cause: error),
      );
    }
  }

  @override
  Future<Result<VehiclePart>> update(VehiclePart part) async {
    try {
      await _db
          .into(_db.vehicleParts)
          .insertOnConflictUpdate(PartsMapper.vehiclePartCompanion(part));
      return Success(part);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update part', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.vehicleParts)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete part', cause: error),
      );
    }
  }
}
