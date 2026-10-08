import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/data/mappers/vehicle_mapper.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';

class DriftVehicleRepository implements VehicleRepository {
  DriftVehicleRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<Vehicle>>> getActiveVehicles() async {
    try {
      final List<VehicleRow> rows =
          await (_db.select(_db.vehicles)
                ..where((t) => t.isArchived.equals(false))
                ..orderBy([(t) => OrderingTerm.asc(t.nickname)]))
              .get();
      return Success(rows.map(VehicleMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load vehicles', cause: error),
      );
    }
  }

  @override
  Future<Result<Vehicle?>> getById(String id) async {
    try {
      final VehicleRow? row = await (_db.select(
        _db.vehicles,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      return Success(row == null ? null : VehicleMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load vehicle', cause: error),
      );
    }
  }

  @override
  Future<Result<Vehicle>> upsert(Vehicle vehicle) async {
    try {
      await _db
          .into(_db.vehicles)
          .insertOnConflictUpdate(VehicleMapper.toCompanion(vehicle));
      return Success(vehicle);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save vehicle', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> archive(String id) async {
    try {
      await (_db.update(_db.vehicles)..where((t) => t.id.equals(id))).write(
        VehiclesCompanion(
          isArchived: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to archive vehicle', cause: error),
      );
    }
  }
}
