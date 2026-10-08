import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/data/mappers/parts_mapper.dart';
import 'package:garir_khata/features/parts/domain/entities/battery.dart';
import 'package:garir_khata/features/parts/domain/repositories/battery_repository.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';

class DriftBatteryRepository implements BatteryRepository {
  DriftBatteryRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<Battery?>> getActive(String vehicleId) async {
    try {
      final row = await (_db.select(_db.batteries)
            ..where(
              (t) =>
                  t.vehicleId.equals(vehicleId) &
                  t.status.equals(BatteryStatus.active.name),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.installDate)])
            ..limit(1))
          .getSingleOrNull();
      return Success(row == null ? null : PartsMapper.batteryToDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load battery', cause: error),
      );
    }
  }

  @override
  Future<Result<List<Battery>>> getHistory(String vehicleId) async {
    try {
      final rows = await (_db.select(_db.batteries)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.installDate)]))
          .get();
      return Success(rows.map(PartsMapper.batteryToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load battery history', cause: error),
      );
    }
  }

  @override
  Future<Result<Battery?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.batteries)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(row == null ? null : PartsMapper.batteryToDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load battery', cause: error),
      );
    }
  }

  @override
  Future<Result<Battery>> create(Battery battery) async {
    try {
      await _db.transaction(() async {
        await (_db.update(_db.batteries)..where(
              (t) =>
                  t.vehicleId.equals(battery.vehicleId) &
                  t.status.equals(BatteryStatus.active.name),
            ))
            .write(
          BatteriesCompanion(
            status: Value(BatteryStatus.replaced.name),
            updatedAt: Value(battery.updatedAt),
          ),
        );
        await _db
            .into(_db.batteries)
            .insert(PartsMapper.batteryCompanion(battery));
      });
      return Success(battery);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save battery', cause: error),
      );
    }
  }

  @override
  Future<Result<Battery>> replace({
    required Battery oldBattery,
    required Battery newBattery,
  }) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.batteries)
            .insertOnConflictUpdate(
              PartsMapper.batteryCompanion(
                Battery(
                  id: oldBattery.id,
                  vehicleId: oldBattery.vehicleId,
                  brand: oldBattery.brand,
                  model: oldBattery.model,
                  specification: oldBattery.specification,
                  purchaseDate: oldBattery.purchaseDate,
                  installDate: oldBattery.installDate,
                  installOdometer: oldBattery.installOdometer,
                  costPaisa: oldBattery.costPaisa,
                  warrantyEndDate: oldBattery.warrantyEndDate,
                  vendorName: oldBattery.vendorName,
                  status: BatteryStatus.replaced,
                  note: oldBattery.note,
                  createdAt: oldBattery.createdAt,
                  updatedAt: newBattery.updatedAt,
                ),
              ),
            );
        await _db
            .into(_db.batteries)
            .insert(PartsMapper.batteryCompanion(newBattery));
      });
      return Success(newBattery);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to replace battery', cause: error),
      );
    }
  }

  @override
  Future<Result<Battery>> markRemoved(Battery battery) async {
    try {
      final updated = Battery(
        id: battery.id,
        vehicleId: battery.vehicleId,
        brand: battery.brand,
        model: battery.model,
        specification: battery.specification,
        purchaseDate: battery.purchaseDate,
        installDate: battery.installDate,
        installOdometer: battery.installOdometer,
        costPaisa: battery.costPaisa,
        warrantyEndDate: battery.warrantyEndDate,
        vendorName: battery.vendorName,
        status: BatteryStatus.removed,
        note: battery.note,
        createdAt: battery.createdAt,
        updatedAt: DateTime.now(),
      );
      await _db
          .into(_db.batteries)
          .insertOnConflictUpdate(PartsMapper.batteryCompanion(updated));
      return Success(updated);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to mark battery removed', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.batteries)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete battery', cause: error),
      );
    }
  }
}
