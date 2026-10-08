import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_payload.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

typedef NotificationTapCallback = void Function(String? payload);

class LocalNotificationScheduler implements NotificationScheduler {
  LocalNotificationScheduler({
    FlutterLocalNotificationsPlugin? plugin,
    this.onTap,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  /// Set by [ReminderLifecycleHost] for in-app notification taps.
  static NotificationTapCallback? globalOnTap;

  final FlutterLocalNotificationsPlugin _plugin;
  final NotificationTapCallback? onTap;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    tzdata.initializeTimeZones();
    try {
      final TimezoneInfo info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } on Object {
      tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: android,
        iOS: darwin,
        macOS: darwin,
      ),
      onDidReceiveNotificationResponse: (response) {
        (onTap ?? globalOnTap)?.call(response.payload);
      },
    );
    _initialized = true;
  }

  @override
  Future<bool> requestPermission() async {
    await initialize();
    if (kIsWeb) {
      return false;
    }
    if (Platform.isAndroid) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final bool? granted =
          await android?.requestNotificationsPermission();
      return granted ?? false;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final bool? granted = await ios?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return true;
  }

  @override
  Future<void> scheduleReminder({
    required Reminder reminder,
    required DateTime when,
    required String body,
  }) async {
    await initialize();
    final int id = ReminderNotificationPayload.notificationIdFor(reminder.id);
    final payload = ReminderNotificationPayload(
      reminderId: reminder.id,
      vehicleId: reminder.vehicleId,
      entityType: ReminderParsers.entityTypeCode(reminder.relatedEntityType),
      entityId: reminder.relatedEntityId,
    );

    final tz.TZDateTime scheduled = when.isAfter(DateTime.now())
        ? tz.TZDateTime.from(when, tz.local)
        : tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2));

    await _plugin.zonedSchedule(
      id: id,
      title: reminder.title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'garir_khata_reminders',
          'Reminders',
          channelDescription: 'Vehicle document and maintenance reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload.encode(),
    );
  }

  @override
  Future<void> cancelReminder(String reminderId) async {
    await initialize();
    await _plugin.cancel(
      id: ReminderNotificationPayload.notificationIdFor(reminderId),
    );
  }

  @override
  Future<void> cancelAll() async {
    await initialize();
    await _plugin.cancelAll();
  }

  Future<String?> consumeLaunchPayload() async {
    await initialize();
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp == true) {
      return details!.notificationResponse?.payload;
    }
    return null;
  }
}
