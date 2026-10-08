import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/reminder_evaluator.dart';
import 'package:garir_khata/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:garir_khata/features/reminders/domain/snooze_policy.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';

/// Evaluates reminder statuses, persists changes, and syncs local notifications.
class ReminderEngine {
  ReminderEngine({
    required this.reminderRepository,
    required this.vehicleRepository,
    required this.scheduler,
    required this.clock,
  });

  final ReminderRepository reminderRepository;
  final VehicleRepository vehicleRepository;
  final NotificationScheduler scheduler;
  final Clock clock;

  Future<Result<List<Reminder>>> evaluateAll() async {
    final Result<List<Reminder>> active =
        await reminderRepository.getAllActive();
    if (active case Failure(:final error)) {
      return Failure(error);
    }
    final List<Reminder> reminders =
        (active as Success<List<Reminder>>).data;
    final List<Reminder> updated = <Reminder>[];

    for (final Reminder reminder in reminders) {
      final Result<Vehicle?> vehicleResult =
          await vehicleRepository.getById(reminder.vehicleId);
      final Vehicle? vehicle = vehicleResult.dataOrNull;
      if (vehicle == null) {
        continue;
      }
      final Reminder evaluated =
          await _evaluateAndPersist(reminder, vehicle.currentOdometer);
      updated.add(evaluated);
    }
    return Success(updated);
  }

  Future<Result<List<Reminder>>> evaluateForVehicle(String vehicleId) async {
    final Result<Vehicle?> vehicleResult =
        await vehicleRepository.getById(vehicleId);
    final Vehicle? vehicle = vehicleResult.dataOrNull;
    if (vehicle == null) {
      return const Success([]);
    }
    final Result<List<Reminder>> active =
        await reminderRepository.getActive(vehicleId);
    if (active case Failure(:final error)) {
      return Failure(error);
    }
    final List<Reminder> updated = <Reminder>[];
    for (final Reminder reminder in (active as Success<List<Reminder>>).data) {
      updated.add(await _evaluateAndPersist(reminder, vehicle.currentOdometer));
    }
    return Success(updated);
  }

  Future<Reminder> _evaluateAndPersist(
    Reminder reminder,
    int currentOdometer,
  ) async {
    final DateTime now = clock.now();
    final ReminderEvaluation evaluation = ReminderEvaluator.evaluate(
      reminder: reminder,
      currentOdometer: currentOdometer,
      now: now,
    );

    Reminder next = reminder;
    if (reminder.status != evaluation.status && !reminder.isTerminal) {
      next = reminder.copyWith(status: evaluation.status, updatedAt: now);
      await reminderRepository.update(next);
    }

    await _syncNotification(next, evaluation, now);
    return next;
  }

  Future<void> _syncNotification(
    Reminder reminder,
    ReminderEvaluation evaluation,
    DateTime now,
  ) async {
    if (!reminder.notificationEnabled ||
        reminder.isTerminal ||
        SnoozePolicy.shouldSuppressNotification(
          snoozedUntil: reminder.snoozedUntil,
          now: now,
        )) {
      await scheduler.cancelReminder(reminder.id);
      return;
    }

    // Odometer-only reminders cannot be pre-scheduled; notify when due/overdue.
    if (reminder.reminderType == ReminderKind.odometer) {
      if (evaluation.needsAttention && !evaluation.isSnoozed) {
        await scheduler.scheduleReminder(
          reminder: reminder,
          when: now,
          body: _body(reminder, evaluation),
        );
      } else {
        await scheduler.cancelReminder(reminder.id);
      }
      return;
    }

    if (reminder.dueDate == null) {
      await scheduler.cancelReminder(reminder.id);
      return;
    }

    final DateTime fireAt = _scheduleTime(
      dueDate: reminder.dueDate!,
      advanceDays: reminder.advanceDays,
      now: now,
    );
    if (fireAt.isBefore(now.subtract(const Duration(days: 1))) &&
        !evaluation.needsAttention) {
      await scheduler.cancelReminder(reminder.id);
      return;
    }

    await scheduler.scheduleReminder(
      reminder: reminder,
      when: fireAt.isBefore(now) ? now : fireAt,
      body: _body(reminder, evaluation),
    );
  }

  /// Fire at the start of the advance window (or due date if already inside).
  static DateTime _scheduleTime({
    required DateTime dueDate,
    required int advanceDays,
    required DateTime now,
  }) {
    final DateTime due = DateTime(dueDate.year, dueDate.month, dueDate.day, 9);
    final DateTime windowStart = due.subtract(Duration(days: advanceDays));
    if (now.isBefore(windowStart)) {
      return windowStart;
    }
    return due.isAfter(now) ? due : now;
  }

  static String _body(Reminder reminder, ReminderEvaluation evaluation) {
    final parts = <String>[];
    if (evaluation.remainingDays != null) {
      if (evaluation.remainingDays! < 0) {
        parts.add('Overdue by ${-evaluation.remainingDays!} days');
      } else if (evaluation.remainingDays == 0) {
        parts.add('Due today');
      } else {
        parts.add('${evaluation.remainingDays} days remaining');
      }
    }
    if (evaluation.remainingKm != null) {
      if (evaluation.remainingKm! < 0) {
        parts.add('Overdue by ${-evaluation.remainingKm!} km');
      } else if (evaluation.remainingKm == 0) {
        parts.add('Due at current odometer');
      } else {
        parts.add('${evaluation.remainingKm} km remaining');
      }
    }
    if (parts.isEmpty) {
      return reminder.description ?? reminder.title;
    }
    return parts.join(' · ');
  }
}
