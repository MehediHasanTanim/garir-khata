enum ReminderKind { date, odometer, combined }

enum ReminderStatus {
  upcoming,
  dueSoon,
  due,
  overdue,
  completed,
  skipped,
}

enum ReminderRecurrence {
  none,
  daily,
  weekly,
  monthly,
  customDays,
  customKm,
}

enum ReminderEntityType {
  document,
  service,
  oil,
  custom,
  tyre,
  battery,
  other,
}

abstract final class ReminderParsers {
  static ReminderKind kind(String raw) {
    return switch (raw) {
      'odometer' => ReminderKind.odometer,
      'combined' => ReminderKind.combined,
      _ => ReminderKind.date,
    };
  }

  static String kindCode(ReminderKind kind) => switch (kind) {
        ReminderKind.date => 'date',
        ReminderKind.odometer => 'odometer',
        ReminderKind.combined => 'combined',
      };

  static ReminderStatus status(String raw) {
    return switch (raw) {
      'due_soon' => ReminderStatus.dueSoon,
      'due' => ReminderStatus.due,
      'overdue' => ReminderStatus.overdue,
      'completed' => ReminderStatus.completed,
      'skipped' => ReminderStatus.skipped,
      _ => ReminderStatus.upcoming,
    };
  }

  static String statusCode(ReminderStatus status) => switch (status) {
        ReminderStatus.upcoming => 'upcoming',
        ReminderStatus.dueSoon => 'due_soon',
        ReminderStatus.due => 'due',
        ReminderStatus.overdue => 'overdue',
        ReminderStatus.completed => 'completed',
        ReminderStatus.skipped => 'skipped',
      };

  static ReminderRecurrence recurrence(String raw) {
    return switch (raw) {
      'daily' => ReminderRecurrence.daily,
      'weekly' => ReminderRecurrence.weekly,
      'monthly' => ReminderRecurrence.monthly,
      'custom_days' => ReminderRecurrence.customDays,
      'custom_km' => ReminderRecurrence.customKm,
      _ => ReminderRecurrence.none,
    };
  }

  static String recurrenceCode(ReminderRecurrence value) => switch (value) {
        ReminderRecurrence.none => 'none',
        ReminderRecurrence.daily => 'daily',
        ReminderRecurrence.weekly => 'weekly',
        ReminderRecurrence.monthly => 'monthly',
        ReminderRecurrence.customDays => 'custom_days',
        ReminderRecurrence.customKm => 'custom_km',
      };

  static ReminderEntityType? entityType(String? raw) {
    if (raw == null) {
      return null;
    }
    return switch (raw) {
      'document' => ReminderEntityType.document,
      'service' => ReminderEntityType.service,
      'oil' => ReminderEntityType.oil,
      'tyre' => ReminderEntityType.tyre,
      'battery' => ReminderEntityType.battery,
      'other' => ReminderEntityType.other,
      'custom' => ReminderEntityType.custom,
      _ => ReminderEntityType.custom,
    };
  }

  static String? entityTypeCode(ReminderEntityType? type) => switch (type) {
        null => null,
        ReminderEntityType.document => 'document',
        ReminderEntityType.service => 'service',
        ReminderEntityType.oil => 'oil',
        ReminderEntityType.tyre => 'tyre',
        ReminderEntityType.battery => 'battery',
        ReminderEntityType.other => 'other',
        ReminderEntityType.custom => 'custom',
      };
}
