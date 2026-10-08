import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/features/reminders/application/reminder_engine.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:garir_khata/features/reminders/domain/snooze_policy.dart';

class ReminderActions {
  const ReminderActions({
    required this.repository,
    required this.engine,
    required this.scheduler,
    required this.clock,
  });

  final ReminderRepository repository;
  final ReminderEngine engine;
  final NotificationScheduler scheduler;
  final Clock clock;

  Future<Result<Reminder>> snooze(String id, Duration duration) async {
    final Reminder? reminder = (await repository.getById(id)).dataOrNull;
    if (reminder == null) {
      return const Failure(
        NotFoundError(message: 'Reminder not found'),
      );
    }
    final DateTime? until = SnoozePolicy.snoozeUntil(
      now: clock.now(),
      duration: duration,
    );
    if (until == null) {
      return const Failure(
        ValidationError(message: 'Invalid snooze duration', field: 'snooze'),
      );
    }
    final Reminder updated = reminder.copyWith(
      snoozedUntil: until,
      updatedAt: clock.now(),
    );
    final Result<Reminder> saved = await repository.update(updated);
    if (saved case Success()) {
      await scheduler.cancelReminder(id);
      await engine.evaluateForVehicle(reminder.vehicleId);
    }
    return saved;
  }

  Future<Result<Reminder>> complete(String id) async {
    final Reminder? reminder = (await repository.getById(id)).dataOrNull;
    if (reminder == null) {
      return const Failure(
        NotFoundError(message: 'Reminder not found'),
      );
    }
    final DateTime now = clock.now();
    final Reminder updated =
        reminder.recurrenceType != ReminderRecurrence.none
            ? _applyRecurrence(reminder, now)
            : reminder.copyWith(
                status: ReminderStatus.completed,
                completedAt: now,
                clearSnooze: true,
                updatedAt: now,
              );

    final Result<Reminder> saved = await repository.update(updated);
    if (saved case Success(:final data)) {
      if (data.status == ReminderStatus.completed) {
        await scheduler.cancelReminder(id);
      } else {
        await engine.evaluateForVehicle(reminder.vehicleId);
      }
    }
    return saved;
  }

  Future<Result<Reminder>> skip(String id) async {
    final Reminder? reminder = (await repository.getById(id)).dataOrNull;
    if (reminder == null) {
      return const Failure(
        NotFoundError(message: 'Reminder not found'),
      );
    }
    final Reminder updated = reminder.copyWith(
      status: ReminderStatus.skipped,
      clearSnooze: true,
      completedAt: clock.now(),
      updatedAt: clock.now(),
    );
    final Result<Reminder> saved = await repository.update(updated);
    if (saved case Success()) {
      await scheduler.cancelReminder(id);
    }
    return saved;
  }

  Reminder _applyRecurrence(Reminder reminder, DateTime now) {
    DateTime? nextDate = reminder.dueDate;
    int? nextOdo = reminder.dueOdometer;
    switch (reminder.recurrenceType) {
      case ReminderRecurrence.daily:
        nextDate = (reminder.dueDate ?? now).add(const Duration(days: 1));
      case ReminderRecurrence.weekly:
        nextDate = (reminder.dueDate ?? now).add(const Duration(days: 7));
      case ReminderRecurrence.monthly:
        final DateTime base = reminder.dueDate ?? now;
        nextDate = DateTime(base.year, base.month + 1, base.day);
      case ReminderRecurrence.customDays:
        if (reminder.recurrenceDays != null) {
          nextDate = (reminder.dueDate ?? now)
              .add(Duration(days: reminder.recurrenceDays!));
        }
      case ReminderRecurrence.customKm:
        if (reminder.recurrenceKm != null && reminder.dueOdometer != null) {
          nextOdo = reminder.dueOdometer! + reminder.recurrenceKm!;
        }
      case ReminderRecurrence.none:
        break;
    }
    return reminder.copyWith(
      status: ReminderStatus.upcoming,
      dueDate: nextDate,
      dueOdometer: nextOdo,
      clearSnooze: true,
      clearCompleted: true,
      updatedAt: now,
    );
  }
}
