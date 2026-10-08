import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/data/mappers/parts_mapper.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';
import 'package:garir_khata/features/parts/domain/repositories/repair_repository.dart';

class DriftRepairRepository implements RepairRepository {
  DriftRepairRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<Repair>>> getHistory(
    String vehicleId, {
    int limit = 50,
  }) async {
    try {
      final rows = await (_db.select(_db.repairs)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.repairDate)])
            ..limit(limit))
          .get();
      final List<Repair> repairs = <Repair>[];
      for (final row in rows) {
        repairs.add(
          PartsMapper.repairToDomain(row, parts: await _partsFor(row.id)),
        );
      }
      return Success(repairs);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load repairs', cause: error),
      );
    }
  }

  @override
  Future<Result<Repair?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.repairs)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const Success(null);
      }
      return Success(
        PartsMapper.repairToDomain(row, parts: await _partsFor(id)),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load repair', cause: error),
      );
    }
  }

  @override
  Future<Result<Repair>> createWithParts(Repair repair) async {
    try {
      await _db.transaction(() async {
        await _db.into(_db.repairs).insert(PartsMapper.repairCompanion(repair));
        for (final part in repair.parts) {
          await _db
              .into(_db.repairParts)
              .insert(PartsMapper.repairPartCompanion(part));
        }
        await _bumpOdometer(repair.vehicleId, repair.odometer, repair.updatedAt);
      });
      return Success(repair);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save repair', cause: error),
      );
    }
  }

  @override
  Future<Result<Repair>> updateWithParts(Repair repair) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.repairs)
            .insertOnConflictUpdate(PartsMapper.repairCompanion(repair));
        await (_db.delete(_db.repairParts)
              ..where((t) => t.repairId.equals(repair.id)))
            .go();
        for (final part in repair.parts) {
          await _db
              .into(_db.repairParts)
              .insert(PartsMapper.repairPartCompanion(part));
        }
      });
      return Success(repair);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update repair', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.repairs)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete repair', cause: error),
      );
    }
  }

  Future<List<RepairPart>> _partsFor(String repairId) async {
    final rows = await (_db.select(_db.repairParts)
          ..where((t) => t.repairId.equals(repairId)))
        .get();
    return rows.map(PartsMapper.repairPartToDomain).toList();
  }

  Future<void> _bumpOdometer(
    String vehicleId,
    int odometer,
    DateTime updatedAt,
  ) async {
    final vehicle = await (_db.select(_db.vehicles)
          ..where((t) => t.id.equals(vehicleId)))
        .getSingleOrNull();
    if (vehicle != null && odometer >= vehicle.currentOdometer) {
      await (_db.update(_db.vehicles)..where((t) => t.id.equals(vehicleId)))
          .write(
        VehiclesCompanion(
          currentOdometer: Value(odometer),
          updatedAt: Value(updatedAt),
        ),
      );
    }
  }
}
