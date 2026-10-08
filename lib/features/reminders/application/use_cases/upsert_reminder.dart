import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/reminders/application/reminder_engine.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/repositories/reminder_repository.dart';

class ReminderInput {
  const ReminderInput({
    required this.vehicleId,
    required this.title,
    required this.reminderType,
    this.id,
    this.description,
    this.dueDate,
    this.dueOdometer,
    this.advanceDays = 30,
    this.advanceKm = 500,
    this.recurrenceType = ReminderRecurrence.none,
    this.recurrenceDays,
    this.recurrenceKm,
    this.relatedEntityType,
    this.relatedEntityId,
    this.notificationEnabled = true,
  });

  final String? id;
  final String vehicleId;
  final String title;
  final String? description;
  final ReminderKind reminderType;
  final DateTime? dueDate;
  final int? dueOdometer;
  final int advanceDays;
  final int advanceKm;
  final ReminderRecurrence recurrenceType;
  final int? recurrenceDays;
  final int? recurrenceKm;
  final ReminderEntityType? relatedEntityType;
  final String? relatedEntityId;
  final bool notificationEnabled;
}

class UpsertReminder {
  const UpsertReminder({
    required this.repository,
    required this.engine,
    required this.uuidGenerator,
    required this.clock,
  });

  final ReminderRepository repository;
  final ReminderEngine engine;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<Reminder>> call(ReminderInput input) async {
    if (input.vehicleId.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Vehicle is required', field: 'vehicleId'),
      );
    }
    if (input.title.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Title is required', field: 'title'),
      );
    }
    if (input.reminderType == ReminderKind.date && input.dueDate == null) {
      return const Failure(
        ValidationError(message: 'Due date is required', field: 'dueDate'),
      );
    }
    if (input.reminderType == ReminderKind.odometer &&
        input.dueOdometer == null) {
      return const Failure(
        ValidationError(
          message: 'Due odometer is required',
          field: 'dueOdometer',
        ),
      );
    }
    if (input.reminderType == ReminderKind.combined &&
        input.dueDate == null &&
        input.dueOdometer == null) {
      return const Failure(
        ValidationError(
          message: 'Date or odometer threshold is required',
          field: 'threshold',
        ),
      );
    }

    final DateTime now = clock.now();
    final String id = input.id ?? uuidGenerator.v4();
    Reminder? existing;
    if (input.id != null) {
      existing = (await repository.getById(id)).dataOrNull;
    }

    final Reminder reminder = Reminder(
      id: id,
      vehicleId: input.vehicleId,
      relatedEntityType: input.relatedEntityType,
      relatedEntityId: input.relatedEntityId,
      reminderType: input.reminderType,
      title: input.title.trim(),
      description: input.description?.trim().isEmpty == true
          ? null
          : input.description?.trim(),
      dueDate: input.dueDate,
      dueOdometer: input.dueOdometer,
      advanceDays: input.advanceDays,
      advanceKm: input.advanceKm,
      recurrenceType: input.recurrenceType,
      recurrenceDays: input.recurrenceDays,
      recurrenceKm: input.recurrenceKm,
      status: existing?.status ?? ReminderStatus.upcoming,
      notificationEnabled: input.notificationEnabled,
      snoozedUntil: existing?.snoozedUntil,
      lastTriggeredAt: existing?.lastTriggeredAt,
      completedAt: existing?.completedAt,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    final Result<Reminder> saved = existing == null
        ? await repository.create(reminder)
        : await repository.update(reminder);
    if (saved case Success()) {
      await engine.evaluateForVehicle(input.vehicleId);
    }
    return saved;
  }
}
