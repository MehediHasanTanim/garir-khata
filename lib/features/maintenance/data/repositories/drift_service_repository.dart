import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/maintenance/data/mappers/maintenance_mapper.dart';
import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/service_repository.dart';
import 'package:garir_khata/features/odometer/data/mappers/odometer_mapper.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

class DriftServiceRepository implements ServiceRepository {
  DriftServiceRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<MaintenanceTemplate>>> getTemplates({
    String? vehicleType,
  }) async {
    try {
      final query = _db.select(_db.maintenanceTemplates)
        ..where((t) => t.isActive.equals(true))
        ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
      if (vehicleType != null) {
        query.where(
          (t) => t.vehicleType.equals(vehicleType) | t.vehicleType.equals('all'),
        );
      }
      final rows = await query.get();
      return Success(rows.map(MaintenanceMapper.templateToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load templates', cause: error),
      );
    }
  }

  @override
  Future<Result<MaintenanceTemplate?>> getTemplateByCode({
    required String code,
    required String vehicleType,
  }) async {
    try {
      final row = await (_db.select(_db.maintenanceTemplates)
            ..where(
              (t) =>
                  t.code.equals(code) &
                  (t.vehicleType.equals(vehicleType) |
                      t.vehicleType.equals('all')),
            )
            ..limit(1))
          .getSingleOrNull();
      return Success(
        row == null ? null : MaintenanceMapper.templateToDomain(row),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load template', cause: error),
      );
    }
  }

  @override
  Future<Result<List<ServiceRecord>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final rows = await (_db.select(_db.serviceRecords)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.serviceDate)])
            ..limit(limit, offset: offset))
          .get();
      final List<ServiceRecord> records = <ServiceRecord>[];
      for (final row in rows) {
        final items = await _itemsFor(row.id);
        records.add(MaintenanceMapper.recordToDomain(row, items: items));
      }
      return Success(records);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load service history', cause: error),
      );
    }
  }

  @override
  Future<Result<ServiceRecord?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.serviceRecords)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const Success(null);
      }
      final items = await _itemsFor(id);
      return Success(MaintenanceMapper.recordToDomain(row, items: items));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load service', cause: error),
      );
    }
  }

  @override
  Future<Result<ServiceRecord>> createWithItems(ServiceRecord record) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.serviceRecords)
            .insert(MaintenanceMapper.recordCompanion(record));
        for (final item in record.items) {
          await _db
              .into(_db.serviceItems)
              .insert(MaintenanceMapper.itemCompanion(item));
        }
        await _updateVehicleOdometer(
          record.vehicleId,
          record.odometer,
          record.updatedAt,
        );
      });
      return Success(record);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save service', cause: error),
      );
    }
  }

  @override
  Future<Result<ServiceRecord>> updateWithItems(ServiceRecord record) async {
    try {
      await _db.transaction(() async {
        await _db
            .into(_db.serviceRecords)
            .insertOnConflictUpdate(MaintenanceMapper.recordCompanion(record));
        await (_db.delete(_db.serviceItems)
              ..where((t) => t.serviceRecordId.equals(record.id)))
            .go();
        for (final item in record.items) {
          await _db
              .into(_db.serviceItems)
              .insert(MaintenanceMapper.itemCompanion(item));
        }
        await _recalcVehicleOdometer(record.vehicleId, record.updatedAt);
      });
      return Success(record);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update service', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      final existing = await (_db.select(_db.serviceRecords)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const Success(null);
      }
      await _db.transaction(() async {
        await (_db.delete(_db.serviceItems)
              ..where((t) => t.serviceRecordId.equals(id)))
            .go();
        await (_db.delete(_db.serviceRecords)..where((t) => t.id.equals(id)))
            .go();
        await (_db.delete(_db.odometerEntries)..where(
              (t) =>
                  t.sourceType.equals(OdometerSourceType.service.name) &
                  t.sourceRecordId.equals(id),
            ))
            .go();
        await _recalcVehicleOdometer(existing.vehicleId, DateTime.now());
      });
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete service', cause: error),
      );
    }
  }

  @override
  Future<Result<List<DueServiceItem>>> getDueServices({
    required String vehicleId,
    required int currentOdometer,
    DateTime? now,
  }) async {
    try {
      final DateTime anchor = now ?? DateTime.now();
      final List<DueServiceItem> due = <DueServiceItem>[];

      final services = await (_db.select(_db.serviceRecords)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.serviceDate)]))
          .get();
      for (final service in services) {
        if (service.nextDueDate == null && service.nextDueOdometer == null) {
          continue;
        }
        final status = NextDueCalculator.evaluate(
          currentOdometer: currentOdometer,
          now: anchor,
          nextDueDate: service.nextDueDate,
          nextDueOdometer: service.nextDueOdometer,
        );
        if (!status.isDueSoonOrOverdue) {
          continue;
        }
        final items = await _itemsFor(service.id);
        due.add(
          DueServiceItem(
            title: items.isEmpty ? 'Service' : items.first.title,
            sourceType: 'service',
            sourceId: service.id,
            nextDueDate: service.nextDueDate,
            nextDueOdometer: service.nextDueOdometer,
            remainingKm: status.remainingKm,
            remainingDays: status.remainingDays,
          ),
        );
      }

      final oils = await (_db.select(_db.oilChanges)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.occurredOn)])
            ..limit(1))
          .get();
      for (final oil in oils) {
        if (oil.nextDueDate == null && oil.nextDueOdometer == null) {
          continue;
        }
        final status = NextDueCalculator.evaluate(
          currentOdometer: currentOdometer,
          now: anchor,
          nextDueDate: oil.nextDueDate,
          nextDueOdometer: oil.nextDueOdometer,
        );
        if (!status.isDueSoonOrOverdue) {
          continue;
        }
        due.add(
          DueServiceItem(
            title: 'Engine oil',
            sourceType: 'oil',
            sourceId: oil.id,
            nextDueDate: oil.nextDueDate,
            nextDueOdometer: oil.nextDueOdometer,
            remainingKm: status.remainingKm,
            remainingDays: status.remainingDays,
          ),
        );
      }

      return Success(due);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load due services', cause: error),
      );
    }
  }

  Future<List<ServiceItem>> _itemsFor(String serviceId) async {
    final rows = await (_db.select(_db.serviceItems)
          ..where((t) => t.serviceRecordId.equals(serviceId)))
        .get();
    return rows.map(MaintenanceMapper.itemToDomain).toList();
  }

  Future<void> _updateVehicleOdometer(
    String vehicleId,
    int odometer,
    DateTime updatedAt,
  ) async {
    final vehicle = await (_db.select(_db.vehicles)
          ..where((t) => t.id.equals(vehicleId)))
        .getSingleOrNull();
    if (vehicle == null) {
      return;
    }
    if (odometer >= vehicle.currentOdometer) {
      await (_db.update(_db.vehicles)..where((t) => t.id.equals(vehicleId)))
          .write(
        VehiclesCompanion(
          currentOdometer: Value(odometer),
          updatedAt: Value(updatedAt),
        ),
      );
    }
  }

  Future<void> _recalcVehicleOdometer(String vehicleId, DateTime updatedAt) async {
    final latest = await (_db.select(_db.odometerEntries)
          ..where((t) => t.vehicleId.equals(vehicleId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.odometer),
            (t) => OrderingTerm.desc(t.recordedAt),
          ])
          ..limit(1))
        .getSingleOrNull();
    await (_db.update(_db.vehicles)..where((t) => t.id.equals(vehicleId)))
        .write(
      VehiclesCompanion(
        currentOdometer: Value(latest?.odometer ?? 0),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<void> insertOdometer(OdometerEntry entry) async {
    await _db
        .into(_db.odometerEntries)
        .insert(OdometerMapper.toCompanion(entry));
  }
}
