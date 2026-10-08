import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/maintenance/data/mappers/maintenance_mapper.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/oil_repository.dart';
import 'package:garir_khata/features/odometer/data/mappers/odometer_mapper.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

class DriftOilRepository implements OilRepository {
  DriftOilRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<OilChange>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final rows = await (_db.select(_db.oilChanges)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.occurredOn)])
            ..limit(limit, offset: offset))
          .get();
      return Success(rows.map(MaintenanceMapper.oilToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load oil history', cause: error),
      );
    }
  }

  @override
  Future<Result<OilChange?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.oilChanges)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(row == null ? null : MaintenanceMapper.oilToDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load oil change', cause: error),
      );
    }
  }

  @override
  Future<Result<OilChange?>> getLatest(String vehicleId) async {
    try {
      final row = await (_db.select(_db.oilChanges)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.occurredOn)])
            ..limit(1))
          .getSingleOrNull();
      return Success(row == null ? null : MaintenanceMapper.oilToDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load latest oil change', cause: error),
      );
    }
  }

  @override
  Future<Result<OilChange>> createBundle(OilChangeBundle bundle) async {
    try {
      await _db.transaction(() async {
        if (bundle.serviceRecord != null) {
          await _db
              .into(_db.serviceRecords)
              .insert(
                MaintenanceMapper.recordCompanion(bundle.serviceRecord!),
              );
          for (final item in bundle.serviceRecord!.items) {
            await _db
                .into(_db.serviceItems)
                .insert(MaintenanceMapper.itemCompanion(item));
          }
        }
        await _db
            .into(_db.oilChanges)
            .insert(MaintenanceMapper.oilCompanion(bundle.oilChange));
        if (bundle.odometerEntry != null) {
          await _db
              .into(_db.odometerEntries)
              .insert(OdometerMapper.toCompanion(bundle.odometerEntry!));
        }
        final vehicle = await (_db.select(_db.vehicles)
              ..where((t) => t.id.equals(bundle.oilChange.vehicleId)))
            .getSingleOrNull();
        if (vehicle != null &&
            bundle.oilChange.odometer >= vehicle.currentOdometer) {
          await (_db.update(_db.vehicles)
                ..where((t) => t.id.equals(bundle.oilChange.vehicleId)))
              .write(
            VehiclesCompanion(
              currentOdometer: Value(bundle.oilChange.odometer),
              updatedAt: Value(bundle.oilChange.updatedAt),
            ),
          );
        }
      });
      return Success(bundle.oilChange);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save oil change', cause: error),
      );
    }
  }

  @override
  Future<Result<OilChange>> update(OilChange oilChange) async {
    try {
      await _db
          .into(_db.oilChanges)
          .insertOnConflictUpdate(MaintenanceMapper.oilCompanion(oilChange));
      return Success(oilChange);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update oil change', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      final existing = await (_db.select(_db.oilChanges)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const Success(null);
      }
      await _db.transaction(() async {
        final String? serviceId = existing.serviceRecordId;
        await (_db.delete(_db.oilChanges)..where((t) => t.id.equals(id))).go();
        await (_db.delete(_db.odometerEntries)..where(
              (t) =>
                  t.sourceType.equals(OdometerSourceType.oilChange.name) &
                  t.sourceRecordId.equals(id),
            ))
            .go();
        if (serviceId != null) {
          await (_db.delete(_db.serviceItems)
                ..where((t) => t.serviceRecordId.equals(serviceId)))
              .go();
          await (_db.delete(_db.serviceRecords)
                ..where((t) => t.id.equals(serviceId)))
              .go();
          await (_db.delete(_db.odometerEntries)..where(
                (t) =>
                    t.sourceType.equals(OdometerSourceType.service.name) &
                    t.sourceRecordId.equals(serviceId),
              ))
              .go();
        }
      });
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete oil change', cause: error),
      );
    }
  }
}
