/// Snooze duration options and application rules for reminders.
abstract final class SnoozePolicy {
  static const Duration oneHour = Duration(hours: 1);
  static const Duration fourHours = Duration(hours: 4);
  static const Duration oneDay = Duration(days: 1);
  static const Duration threeDays = Duration(days: 3);
  static const Duration oneWeek = Duration(days: 7);

  static const List<Duration> presets = [
    oneHour,
    fourHours,
    oneDay,
    threeDays,
    oneWeek,
  ];

  /// Returns the snooze-until timestamp; rejects non-positive durations.
  static DateTime? snoozeUntil({
    required DateTime now,
    required Duration duration,
  }) {
    if (duration <= Duration.zero) {
      return null;
    }
    return now.add(duration);
  }

  /// While snoozed, notifications should not fire even if status is due.
  static bool shouldSuppressNotification({
    required DateTime? snoozedUntil,
    required DateTime now,
  }) {
    if (snoozedUntil == null) {
      return false;
    }
    return snoozedUntil.isAfter(now);
  }
}
