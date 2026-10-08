import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_payload.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';

void main() {
  late InMemoryNotificationScheduler scheduler;
  final now = DateTime(2026, 10, 8);

  setUp(() {
    scheduler = InMemoryNotificationScheduler();
  });

  Reminder reminder() => Reminder(
        id: 'rem-1',
        vehicleId: 'veh-1',
        relatedEntityType: ReminderEntityType.document,
        relatedEntityId: 'doc-1',
        reminderType: ReminderKind.date,
        title: 'Insurance expiry',
        dueDate: DateTime(2026, 11, 8),
        advanceDays: 30,
        advanceKm: 500,
        recurrenceType: ReminderRecurrence.none,
        status: ReminderStatus.upcoming,
        notificationEnabled: true,
        createdAt: now,
        updatedAt: now,
      );

  test('schedules reminder with stable notification id and payload', () async {
    final Reminder r = reminder();
    await scheduler.scheduleReminder(
      reminder: r,
      when: DateTime(2026, 10, 9, 9),
      body: '30 days remaining',
    );
    expect(scheduler.scheduled.containsKey('rem-1'), isTrue);
    expect(
      scheduler.scheduled['rem-1']!.notificationId,
      ReminderNotificationPayload.notificationIdFor('rem-1'),
    );
    expect(scheduler.scheduled['rem-1']!.payload.entityType, 'document');
    expect(scheduler.scheduled['rem-1']!.payload.deepLinkPath(), '/reminders/rem-1');
  });

  test('cancel removes scheduled notification', () async {
    await scheduler.scheduleReminder(
      reminder: reminder(),
      when: now,
      body: 'Due',
    );
    await scheduler.cancelReminder('rem-1');
    expect(scheduler.scheduled.containsKey('rem-1'), isFalse);
    expect(scheduler.cancelled, contains('rem-1'));
  });

  test('update replaces previous schedule', () async {
    final Reminder r = reminder();
    await scheduler.scheduleReminder(
      reminder: r,
      when: now,
      body: 'first',
    );
    await scheduler.scheduleReminder(
      reminder: r,
      when: now.add(const Duration(days: 1)),
      body: 'updated',
    );
    expect(scheduler.scheduled['rem-1']!.body, 'updated');
  });

  test('payload parse round-trip', () {
    const payload = ReminderNotificationPayload(
      reminderId: 'r',
      vehicleId: 'v',
      entityType: 'document',
      entityId: 'd',
    );
    final parsed = ReminderNotificationPayload.tryParse(payload.encode());
    expect(parsed?.reminderId, 'r');
    expect(parsed?.entityId, 'd');
  });
}
