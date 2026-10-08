import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';

abstract final class ReminderMapper {
  static Reminder toDomain(ReminderRow row) {
    return Reminder(
      id: row.id,
      vehicleId: row.vehicleId,
      relatedEntityType: ReminderParsers.entityType(row.relatedEntityType),
      relatedEntityId: row.relatedEntityId,
      reminderType: ReminderParsers.kind(row.reminderType),
      title: row.title,
      description: row.description,
      dueDate: row.dueDate,
      dueOdometer: row.dueOdometer,
      advanceDays: row.advanceDays,
      advanceKm: row.advanceKm,
      recurrenceType: ReminderParsers.recurrence(row.recurrenceType),
      recurrenceDays: row.recurrenceDays,
      recurrenceKm: row.recurrenceKm,
      status: ReminderParsers.status(row.status),
      notificationEnabled: row.notificationEnabled,
      snoozedUntil: row.snoozedUntil,
      lastTriggeredAt: row.lastTriggeredAt,
      completedAt: row.completedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static RemindersCompanion toCompanion(Reminder reminder) {
    return RemindersCompanion(
      id: Value(reminder.id),
      vehicleId: Value(reminder.vehicleId),
      relatedEntityType: Value(
        ReminderParsers.entityTypeCode(reminder.relatedEntityType),
      ),
      relatedEntityId: Value(reminder.relatedEntityId),
      reminderType: Value(ReminderParsers.kindCode(reminder.reminderType)),
      title: Value(reminder.title),
      description: Value(reminder.description),
      dueDate: Value(reminder.dueDate),
      dueOdometer: Value(reminder.dueOdometer),
      advanceDays: Value(reminder.advanceDays),
      advanceKm: Value(reminder.advanceKm),
      recurrenceType: Value(
        ReminderParsers.recurrenceCode(reminder.recurrenceType),
      ),
      recurrenceDays: Value(reminder.recurrenceDays),
      recurrenceKm: Value(reminder.recurrenceKm),
      status: Value(ReminderParsers.statusCode(reminder.status)),
      notificationEnabled: Value(reminder.notificationEnabled),
      snoozedUntil: Value(reminder.snoozedUntil),
      lastTriggeredAt: Value(reminder.lastTriggeredAt),
      completedAt: Value(reminder.completedAt),
      createdAt: Value(reminder.createdAt),
      updatedAt: Value(reminder.updatedAt),
    );
  }
}
