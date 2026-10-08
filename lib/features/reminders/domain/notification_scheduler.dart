import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_payload.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';

/// Abstraction over platform local notifications for testability.
abstract interface class NotificationScheduler {
  Future<bool> requestPermission();
  Future<void> scheduleReminder({
    required Reminder reminder,
    required DateTime when,
    required String body,
  });
  Future<void> cancelReminder(String reminderId);
  Future<void> cancelAll();
}

class ScheduledNotificationRecord {
  ScheduledNotificationRecord({
    required this.reminder,
    required this.when,
    required this.body,
    required this.notificationId,
    required this.payload,
  });

  final Reminder reminder;
  final DateTime when;
  final String body;
  final int notificationId;
  final ReminderNotificationPayload payload;
}

class InMemoryNotificationScheduler implements NotificationScheduler {
  final Map<String, ScheduledNotificationRecord> scheduled =
      <String, ScheduledNotificationRecord>{};
  bool permissionGranted = true;
  final List<String> cancelled = <String>[];

  @override
  Future<bool> requestPermission() async => permissionGranted;

  @override
  Future<void> scheduleReminder({
    required Reminder reminder,
    required DateTime when,
    required String body,
  }) async {
    scheduled[reminder.id] = ScheduledNotificationRecord(
      reminder: reminder,
      when: when,
      body: body,
      notificationId: ReminderNotificationPayload.notificationIdFor(reminder.id),
      payload: ReminderNotificationPayload(
        reminderId: reminder.id,
        vehicleId: reminder.vehicleId,
        entityType: ReminderParsers.entityTypeCode(reminder.relatedEntityType),
        entityId: reminder.relatedEntityId,
      ),
    );
  }

  @override
  Future<void> cancelReminder(String reminderId) async {
    scheduled.remove(reminderId);
    cancelled.add(reminderId);
  }

  @override
  Future<void> cancelAll() async {
    scheduled.clear();
  }
}
