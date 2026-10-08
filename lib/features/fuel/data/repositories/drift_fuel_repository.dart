import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/fuel/data/mappers/fuel_mapper.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/odometer/data/mappers/odometer_mapper.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

class DriftFuelRepository implements FuelRepository {
  DriftFuelRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<FuelEntry>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final List<FuelEntryRow> rows = await (_db.select(_db.fuelEntries)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.entryDateTime)])
            ..limit(limit, offset: offset))
          .get();
      return Success(rows.map(FuelMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load fuel history', cause: error),
      );
    }
  }

  @override
  Future<Result<FuelEntry?>> getById(String id) async {
    try {
      final FuelEntryRow? row = await (_db.select(_db.fuelEntries)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(row == null ? null : FuelMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load fuel entry', cause: error),
      );
    }
  }

  @override
  Future<Result<FuelEntry>> createWithOdometer({
    required FuelEntry fuel,
    required OdometerEntry odometerEntry,
  }) async {
    try {
      await _db.transaction(() async {
        await _db.into(_db.fuelEntries).insert(FuelMapper.toCompanion(fuel));
        await _db
            .into(_db.odometerEntries)
            .insert(OdometerMapper.toCompanion(odometerEntry));
        await (_db.update(_db.vehicles)
              ..where((t) => t.id.equals(fuel.vehicleId)))
            .write(
          VehiclesCompanion(
            currentOdometer: Value(fuel.odometer),
            updatedAt: Value(fuel.updatedAt),
          ),
        );
      });
      return Success(fuel);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save fuel entry', cause: error),
      );
    }
  }

  @override
  Future<Result<FuelEntry>> updateWithOdometer({
    required FuelEntry fuel,
    required OdometerEntry odometerEntry,
  }) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.fuelEntries)
            .insertOnConflictUpdate(FuelMapper.toCompanion(fuel));
        await (_db.delete(_db.odometerEntries)..where(
              (t) =>
                  t.sourceType.equals(OdometerSourceType.fuel.name) &
                  t.sourceRecordId.equals(fuel.id),
            ))
            .go();
        await _db
            .into(_db.odometerEntries)
            .insert(OdometerMapper.toCompanion(odometerEntry));

        final OdometerEntryRow? latest = await (_db.select(_db.odometerEntries)
              ..where((t) => t.vehicleId.equals(fuel.vehicleId))
              ..orderBy([
                (t) => OrderingTerm.desc(t.odometer),
                (t) => OrderingTerm.desc(t.recordedAt),
              ])
              ..limit(1))
            .getSingleOrNull();
        await (_db.update(_db.vehicles)
              ..where((t) => t.id.equals(fuel.vehicleId)))
            .write(
          VehiclesCompanion(
            currentOdometer: Value(latest?.odometer ?? fuel.odometer),
            updatedAt: Value(fuel.updatedAt),
          ),
        );
      });
      return Success(fuel);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update fuel entry', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      final FuelEntryRow? existing = await (_db.select(_db.fuelEntries)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const Success(null);
      }

      await _db.transaction(() async {
        await (_db.delete(_db.fuelEntries)..where((t) => t.id.equals(id))).go();
        await (_db.delete(_db.odometerEntries)..where(
              (t) =>
                  t.sourceType.equals(OdometerSourceType.fuel.name) &
                  t.sourceRecordId.equals(id),
            ))
            .go();

        final OdometerEntryRow? latest = await (_db.select(_db.odometerEntries)
              ..where((t) => t.vehicleId.equals(existing.vehicleId))
              ..orderBy([
                (t) => OrderingTerm.desc(t.odometer),
                (t) => OrderingTerm.desc(t.recordedAt),
              ])
              ..limit(1))
            .getSingleOrNull();
        await (_db.update(_db.vehicles)
              ..where((t) => t.id.equals(existing.vehicleId)))
            .write(
          VehiclesCompanion(
            currentOdometer: Value(latest?.odometer ?? 0),
            updatedAt: Value(DateTime.now()),
          ),
        );
      });
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete fuel entry', cause: error),
      );
    }
  }

  @override
  Future<Result<List<FuelEntry>>> findSimilar({
    required String vehicleId,
    required int odometer,
    required DateTime dateTime,
    required int totalCostPaisa,
    String? excludeId,
  }) async {
    try {
      final DateTime from = dateTime.subtract(const Duration(hours: 6));
      final DateTime to = dateTime.add(const Duration(hours: 6));
      final List<FuelEntryRow> rows = await (_db.select(_db.fuelEntries)
            ..where(
              (t) =>
                  t.vehicleId.equals(vehicleId) &
                  t.odometer.equals(odometer) &
                  t.entryDateTime.isBetweenValues(from, to) &
                  t.totalCostPaisa.equals(totalCostPaisa),
            ))
          .get();
      final List<FuelEntry> entries = rows
          .map(FuelMapper.toDomain)
          .where((e) => excludeId == null || e.id != excludeId)
          .toList();
      return Success(entries);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to check duplicates', cause: error),
      );
    }
  }
}
