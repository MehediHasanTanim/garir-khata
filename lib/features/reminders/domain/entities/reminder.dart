import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';

class Reminder {
  const Reminder({
    required this.id,
    required this.vehicleId,
    required this.reminderType,
    required this.title,
    required this.advanceDays,
    required this.advanceKm,
    required this.recurrenceType,
    required this.status,
    required this.notificationEnabled,
    required this.createdAt,
    required this.updatedAt,
    this.relatedEntityType,
    this.relatedEntityId,
    this.description,
    this.dueDate,
    this.dueOdometer,
    this.recurrenceDays,
    this.recurrenceKm,
    this.snoozedUntil,
    this.lastTriggeredAt,
    this.completedAt,
  });

  final String id;
  final String vehicleId;
  final ReminderEntityType? relatedEntityType;
  final String? relatedEntityId;
  final ReminderKind reminderType;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final int? dueOdometer;
  final int advanceDays;
  final int advanceKm;
  final ReminderRecurrence recurrenceType;
  final int? recurrenceDays;
  final int? recurrenceKm;
  final ReminderStatus status;
  final bool notificationEnabled;
  final DateTime? snoozedUntil;
  final DateTime? lastTriggeredAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isTerminal =>
      status == ReminderStatus.completed || status == ReminderStatus.skipped;

  bool isSnoozed({DateTime? now}) {
    if (snoozedUntil == null) {
      return false;
    }
    return snoozedUntil!.isAfter(now ?? DateTime.now());
  }

  Reminder copyWith({
    ReminderStatus? status,
    DateTime? snoozedUntil,
    bool clearSnooze = false,
    DateTime? lastTriggeredAt,
    DateTime? completedAt,
    bool clearCompleted = false,
    DateTime? dueDate,
    int? dueOdometer,
    DateTime? updatedAt,
    bool? notificationEnabled,
  }) {
    return Reminder(
      id: id,
      vehicleId: vehicleId,
      relatedEntityType: relatedEntityType,
      relatedEntityId: relatedEntityId,
      reminderType: reminderType,
      title: title,
      description: description,
      dueDate: dueDate ?? this.dueDate,
      dueOdometer: dueOdometer ?? this.dueOdometer,
      advanceDays: advanceDays,
      advanceKm: advanceKm,
      recurrenceType: recurrenceType,
      recurrenceDays: recurrenceDays,
      recurrenceKm: recurrenceKm,
      status: status ?? this.status,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      snoozedUntil: clearSnooze ? null : (snoozedUntil ?? this.snoozedUntil),
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      completedAt:
          clearCompleted ? null : (completedAt ?? this.completedAt),
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ReminderEvaluation {
  const ReminderEvaluation({
    required this.status,
    this.remainingDays,
    this.remainingKm,
    this.isSnoozed = false,
  });

  final ReminderStatus status;
  final int? remainingDays;
  final int? remainingKm;
  final bool isSnoozed;

  bool get needsAttention =>
      status == ReminderStatus.dueSoon ||
      status == ReminderStatus.due ||
      status == ReminderStatus.overdue;
}
