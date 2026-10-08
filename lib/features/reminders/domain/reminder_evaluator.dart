import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';

/// Pure evaluation of reminder urgency from date and/or odometer thresholds.
///
/// Combined rule: whichever threshold comes first (more urgent) wins.
abstract final class ReminderEvaluator {
  /// Common date advance windows used for documents (tax/fitness/insurance).
  static const List<int> dateAdvanceWindows = [30, 14, 7, 1];

  /// Common km advance windows for maintenance.
  static const List<int> kmAdvanceWindows = [500, 200];

  static ReminderEvaluation evaluate({
    required Reminder reminder,
    required int currentOdometer,
    DateTime? now,
  }) {
    final DateTime anchor = now ?? DateTime.now();
    if (reminder.status == ReminderStatus.completed ||
        reminder.status == ReminderStatus.skipped) {
      return ReminderEvaluation(status: reminder.status);
    }

    final bool snoozed = reminder.isSnoozed(now: anchor);
    final ReminderStatus computed = switch (reminder.reminderType) {
      ReminderKind.date => _fromDate(reminder, anchor),
      ReminderKind.odometer => _fromOdometer(reminder, currentOdometer),
      ReminderKind.combined => _moreUrgent(
          _fromDate(reminder, anchor),
          _fromOdometer(reminder, currentOdometer),
        ),
    };

    return ReminderEvaluation(
      status: computed,
      remainingDays: _remainingDays(reminder.dueDate, anchor),
      remainingKm: reminder.dueOdometer == null
          ? null
          : reminder.dueOdometer! - currentOdometer,
      isSnoozed: snoozed,
    );
  }

  /// Date-only status using [advanceDays] as the due-soon window.
  static ReminderStatus evaluateDate({
    required DateTime dueDate,
    required DateTime now,
    int advanceDays = 30,
  }) {
    return _statusFromRemaining(
      remaining: _remainingDays(dueDate, now)!,
      advance: advanceDays,
    );
  }

  /// Odometer-only status using [advanceKm] as the due-soon window.
  static ReminderStatus evaluateOdometer({
    required int dueOdometer,
    required int currentOdometer,
    int advanceKm = 500,
  }) {
    return _statusFromRemaining(
      remaining: dueOdometer - currentOdometer,
      advance: advanceKm,
    );
  }

  /// Combined: due on date OR odometer, whichever comes first.
  static ReminderStatus evaluateCombined({
    DateTime? dueDate,
    int? dueOdometer,
    required DateTime now,
    required int currentOdometer,
    int advanceDays = 30,
    int advanceKm = 500,
  }) {
    final ReminderStatus? dateStatus = dueDate == null
        ? null
        : evaluateDate(dueDate: dueDate, now: now, advanceDays: advanceDays);
    final ReminderStatus? kmStatus = dueOdometer == null
        ? null
        : evaluateOdometer(
            dueOdometer: dueOdometer,
            currentOdometer: currentOdometer,
            advanceKm: advanceKm,
          );
    if (dateStatus == null && kmStatus == null) {
      return ReminderStatus.upcoming;
    }
    if (dateStatus == null) {
      return kmStatus!;
    }
    if (kmStatus == null) {
      return dateStatus;
    }
    return _moreUrgent(dateStatus, kmStatus);
  }

  static ReminderStatus _fromDate(Reminder reminder, DateTime now) {
    if (reminder.dueDate == null) {
      return ReminderStatus.upcoming;
    }
    return evaluateDate(
      dueDate: reminder.dueDate!,
      now: now,
      advanceDays: reminder.advanceDays,
    );
  }

  static ReminderStatus _fromOdometer(Reminder reminder, int currentOdometer) {
    if (reminder.dueOdometer == null) {
      return ReminderStatus.upcoming;
    }
    return evaluateOdometer(
      dueOdometer: reminder.dueOdometer!,
      currentOdometer: currentOdometer,
      advanceKm: reminder.advanceKm,
    );
  }

  static ReminderStatus _statusFromRemaining({
    required int remaining,
    required int advance,
  }) {
    if (remaining < 0) {
      return ReminderStatus.overdue;
    }
    if (remaining == 0) {
      return ReminderStatus.due;
    }
    if (remaining <= advance) {
      return ReminderStatus.dueSoon;
    }
    return ReminderStatus.upcoming;
  }

  static int _urgencyRank(ReminderStatus status) => switch (status) {
        ReminderStatus.overdue => 5,
        ReminderStatus.due => 4,
        ReminderStatus.dueSoon => 3,
        ReminderStatus.upcoming => 2,
        ReminderStatus.completed => 1,
        ReminderStatus.skipped => 0,
      };

  static ReminderStatus _moreUrgent(ReminderStatus a, ReminderStatus b) {
    return _urgencyRank(a) >= _urgencyRank(b) ? a : b;
  }

  static int? _remainingDays(DateTime? dueDate, DateTime now) {
    if (dueDate == null) {
      return null;
    }
    final DateTime due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final DateTime today = DateTime(now.year, now.month, now.day);
    return due.difference(today).inDays;
  }
}
