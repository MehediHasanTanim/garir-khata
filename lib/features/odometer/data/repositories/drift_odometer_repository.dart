import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/odometer/data/mappers/odometer_mapper.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/odometer/domain/repositories/odometer_repository.dart';

class DriftOdometerRepository implements OdometerRepository {
  DriftOdometerRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<OdometerEntry?>> getLatest(String vehicleId) async {
    try {
      final OdometerEntryRow? row = await (_db.select(_db.odometerEntries)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([
              (t) => OrderingTerm.desc(t.odometer),
              (t) => OrderingTerm.desc(t.recordedAt),
            ])
            ..limit(1))
          .getSingleOrNull();
      return Success(row == null ? null : OdometerMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load latest odometer', cause: error),
      );
    }
  }

  @override
  Future<Result<List<OdometerEntry>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final List<OdometerEntryRow> rows = await (_db.select(_db.odometerEntries)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.recordedAt)])
            ..limit(limit, offset: offset))
          .get();
      return Success(rows.map(OdometerMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load odometer history', cause: error),
      );
    }
  }

  @override
  Future<Result<OdometerEntry>> insert(OdometerEntry entry) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.odometerEntries)
            .insert(OdometerMapper.toCompanion(entry));
        await (_db.update(_db.vehicles)
              ..where((t) => t.id.equals(entry.vehicleId)))
            .write(
          VehiclesCompanion(
            currentOdometer: Value(entry.odometer),
            updatedAt: Value(entry.createdAt),
          ),
        );
      });
      return Success(entry);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save odometer', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> deleteBySource({
    required String sourceType,
    required String sourceRecordId,
  }) async {
    try {
      await (_db.delete(_db.odometerEntries)..where(
            (t) =>
                t.sourceType.equals(sourceType) &
                t.sourceRecordId.equals(sourceRecordId),
          ))
          .go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete odometer link', cause: error),
      );
    }
  }

  @override
  Future<Result<int?>> recalculateVehicleCurrentOdometer(
    String vehicleId,
  ) async {
    try {
      final OdometerEntryRow? latest = await (_db.select(_db.odometerEntries)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([
              (t) => OrderingTerm.desc(t.odometer),
              (t) => OrderingTerm.desc(t.recordedAt),
            ])
            ..limit(1))
          .getSingleOrNull();
      final int value = latest?.odometer ?? 0;
      await (_db.update(_db.vehicles)..where((t) => t.id.equals(vehicleId)))
          .write(
        VehiclesCompanion(
          currentOdometer: Value(value),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return Success(latest?.odometer);
    } on Object catch (error) {
      return Failure(
        DatabaseError(
          message: 'Failed to recalculate vehicle odometer',
          cause: error,
        ),
      );
    }
  }
}
