import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reminders/data/mappers/reminder_mapper.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/repositories/reminder_repository.dart';

class DriftReminderRepository implements ReminderRepository {
  DriftReminderRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<Reminder>>> getForVehicle(
    String vehicleId, {
    ReminderStatus? status,
    bool includeTerminal = false,
  }) async {
    try {
      final query = _db.select(_db.reminders)
        ..where((t) => t.vehicleId.equals(vehicleId))
        ..orderBy([
          (t) => OrderingTerm.asc(t.dueDate),
          (t) => OrderingTerm.asc(t.dueOdometer),
        ]);
      if (status != null) {
        query.where(
          (t) => t.status.equals(ReminderParsers.statusCode(status)),
        );
      } else if (!includeTerminal) {
        query.where(
          (t) =>
              t.status.isNotValue(ReminderParsers.statusCode(ReminderStatus.completed)) &
              t.status.isNotValue(ReminderParsers.statusCode(ReminderStatus.skipped)),
        );
      }
      final rows = await query.get();
      return Success(rows.map(ReminderMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load reminders', cause: error),
      );
    }
  }

  @override
  Future<Result<List<Reminder>>> getActive(String vehicleId) async {
    return getForVehicle(vehicleId, includeTerminal: false);
  }

  @override
  Future<Result<List<Reminder>>> getAllActive() async {
    try {
      final rows = await (_db.select(_db.reminders)
            ..where(
              (t) =>
                  t.status.isNotValue(
                    ReminderParsers.statusCode(ReminderStatus.completed),
                  ) &
                  t.status.isNotValue(
                    ReminderParsers.statusCode(ReminderStatus.skipped),
                  ),
            ))
          .get();
      return Success(rows.map(ReminderMapper.toDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load active reminders', cause: error),
      );
    }
  }

  @override
  Future<Result<Reminder?>> getById(String id) async {
    try {
      final row = await (_db.select(_db.reminders)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return Success(row == null ? null : ReminderMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load reminder', cause: error),
      );
    }
  }

  @override
  Future<Result<Reminder?>> findByRelated({
    required String relatedEntityType,
    required String relatedEntityId,
  }) async {
    try {
      final row = await (_db.select(_db.reminders)
            ..where(
              (t) =>
                  t.relatedEntityType.equals(relatedEntityType) &
                  t.relatedEntityId.equals(relatedEntityId),
            )
            ..limit(1))
          .getSingleOrNull();
      return Success(row == null ? null : ReminderMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to find reminder', cause: error),
      );
    }
  }

  @override
  Future<Result<Reminder>> create(Reminder reminder) async {
    try {
      await _db.into(_db.reminders).insert(ReminderMapper.toCompanion(reminder));
      return Success(reminder);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to save reminder', cause: error),
      );
    }
  }

  @override
  Future<Result<Reminder>> update(Reminder reminder) async {
    try {
      await _db
          .into(_db.reminders)
          .insertOnConflictUpdate(ReminderMapper.toCompanion(reminder));
      return Success(reminder);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update reminder', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.reminders)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete reminder', cause: error),
      );
    }
  }
}
