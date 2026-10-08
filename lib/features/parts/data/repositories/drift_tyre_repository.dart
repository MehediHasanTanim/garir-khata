import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/data/mappers/parts_mapper.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/repositories/tyre_repository.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';

class DriftTyreRepository implements TyreRepository {
  DriftTyreRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<Tyre>>> getActive(String vehicleId) async {
    try {
      final rows = await (_db.select(_db.tyres)
            ..where(
              (t) =>
                  t.vehicleId.equals(vehicleId) &
                  t.status.equals(TyreStatus.active.name),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.position)]))
          .get();
      return Success(rows.map(PartsMapper.tyreToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load tyres', cause: error),
      );
    }
  }

  @override
  Future<Result<List<Tyre>>> getHistory(String vehicleId) async {
    try {
      final rows = await (_db.select(_db.tyres)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.installDate)]))
          .get();
      return Success(rows.map(PartsMapper.tyreToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load tyre history', cause: error),
      );
    }
  }

  @override
  Future<Result<Tyre?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.tyres)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const Success(null);
      }
      final events = await (_db.select(_db.tyreEvents)
            ..where((t) => t.tyreId.equals(id))
            ..orderBy([(t) => OrderingTerm.desc(t.occurredOn)]))
          .get();
      return Success(
        PartsMapper.tyreToDomain(
          row,
          events: events.map(PartsMapper.eventToDomain).toList(),
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load tyre', cause: error),
      );
    }
  }

  @override
  Future<Result<Tyre>> create(Tyre tyre, {TyreEvent? installEvent}) async {
    try {
      await _db.transaction(() async {
        // One active tyre per position.
        await (_db.update(_db.tyres)..where(
              (t) =>
                  t.vehicleId.equals(tyre.vehicleId) &
                  t.position.equals(tyre.position.name) &
                  t.status.equals(TyreStatus.active.name),
            ))
            .write(
          TyresCompanion(
            status: Value(TyreStatus.replaced.name),
            updatedAt: Value(tyre.updatedAt),
          ),
        );
        await _db.into(_db.tyres).insert(PartsMapper.tyreCompanion(tyre));
        if (installEvent != null) {
          await _db
              .into(_db.tyreEvents)
              .insert(PartsMapper.eventCompanion(installEvent));
        }
      });
      return Success(tyre);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save tyre', cause: error),
      );
    }
  }

  @override
  Future<Result<Tyre>> update(Tyre tyre) async {
    try {
      await _db
          .into(_db.tyres)
          .insertOnConflictUpdate(PartsMapper.tyreCompanion(tyre));
      return Success(tyre);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update tyre', cause: error),
      );
    }
  }

  @override
  Future<Result<TyreEvent>> addEvent(TyreEvent event) async {
    try {
      await _db.into(_db.tyreEvents).insert(PartsMapper.eventCompanion(event));
      return Success(event);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save tyre event', cause: error),
      );
    }
  }

  @override
  Future<Result<Tyre>> replace({
    required Tyre oldTyre,
    required Tyre newTyre,
    required TyreEvent removeEvent,
    required TyreEvent installEvent,
  }) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.tyres)
            .insertOnConflictUpdate(
              PartsMapper.tyreCompanion(
                Tyre(
                  id: oldTyre.id,
                  vehicleId: oldTyre.vehicleId,
                  position: oldTyre.position,
                  brand: oldTyre.brand,
                  model: oldTyre.model,
                  size: oldTyre.size,
                  purchaseDate: oldTyre.purchaseDate,
                  installDate: oldTyre.installDate,
                  installOdometer: oldTyre.installOdometer,
                  costPaisa: oldTyre.costPaisa,
                  warrantyEndDate: oldTyre.warrantyEndDate,
                  vendorName: oldTyre.vendorName,
                  status: TyreStatus.replaced,
                  note: oldTyre.note,
                  createdAt: oldTyre.createdAt,
                  updatedAt: newTyre.updatedAt,
                ),
              ),
            );
        await _db
            .into(_db.tyreEvents)
            .insert(PartsMapper.eventCompanion(removeEvent));
        await _db.into(_db.tyres).insert(PartsMapper.tyreCompanion(newTyre));
        await _db
            .into(_db.tyreEvents)
            .insert(PartsMapper.eventCompanion(installEvent));
      });
      return Success(newTyre);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to replace tyre', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.tyres)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete tyre', cause: error),
      );
    }
  }
}
