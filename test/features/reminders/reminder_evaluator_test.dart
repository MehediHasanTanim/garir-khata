import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/reminder_evaluator.dart';

void main() {
  final now = DateTime(2026, 10, 8);

  group('date reminder logic', () {
    test('30 days before is dueSoon when advanceDays is 30', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 11, 7),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('14 days before is dueSoon', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 10, 22),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('7 days before is dueSoon', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 10, 15),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('1 day before is dueSoon', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 10, 9),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('due today', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 10, 8),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.due,
      );
    });

    test('expired/overdue', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 10, 1),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.overdue,
      );
    });

    test('more than advance window is upcoming', () {
      expect(
        ReminderEvaluator.evaluateDate(
          dueDate: DateTime(2026, 12, 1),
          now: now,
          advanceDays: 30,
        ),
        ReminderStatus.upcoming,
      );
    });
  });

  group('kilometer reminder logic', () {
    test('500 km remaining is dueSoon with advance 500', () {
      expect(
        ReminderEvaluator.evaluateOdometer(
          dueOdometer: 25500,
          currentOdometer: 25000,
          advanceKm: 500,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('200 km remaining is dueSoon', () {
      expect(
        ReminderEvaluator.evaluateOdometer(
          dueOdometer: 25200,
          currentOdometer: 25000,
          advanceKm: 500,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('due at exact odometer', () {
      expect(
        ReminderEvaluator.evaluateOdometer(
          dueOdometer: 25000,
          currentOdometer: 25000,
          advanceKm: 500,
        ),
        ReminderStatus.due,
      );
    });

    test('overdue past odometer', () {
      expect(
        ReminderEvaluator.evaluateOdometer(
          dueOdometer: 24000,
          currentOdometer: 25000,
          advanceKm: 500,
        ),
        ReminderStatus.overdue,
      );
    });
  });

  group('combined reminder logic', () {
    test('whichever comes first wins — date overdue beats km upcoming', () {
      expect(
        ReminderEvaluator.evaluateCombined(
          dueDate: DateTime(2026, 9, 1),
          dueOdometer: 30000,
          now: now,
          currentOdometer: 25000,
        ),
        ReminderStatus.overdue,
      );
    });

    test('km due soon beats date upcoming', () {
      expect(
        ReminderEvaluator.evaluateCombined(
          dueDate: DateTime(2027, 1, 1),
          dueOdometer: 25200,
          now: now,
          currentOdometer: 25000,
          advanceKm: 500,
        ),
        ReminderStatus.dueSoon,
      );
    });

    test('engine oil style combined evaluation on Reminder', () {
      final reminder = Reminder(
        id: 'r1',
        vehicleId: 'v1',
        reminderType: ReminderKind.combined,
        title: 'Engine oil',
        dueDate: DateTime(2026, 12, 15),
        dueOdometer: 30000,
        advanceDays: 30,
        advanceKm: 500,
        recurrenceType: ReminderRecurrence.none,
        status: ReminderStatus.upcoming,
        notificationEnabled: true,
        createdAt: now,
        updatedAt: now,
      );
      final result = ReminderEvaluator.evaluate(
        reminder: reminder,
        currentOdometer: 29800,
        now: now,
      );
      expect(result.status, ReminderStatus.dueSoon);
      expect(result.remainingKm, 200);
    });
  });
}
