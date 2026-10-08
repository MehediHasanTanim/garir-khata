import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reminders/application/reminder_engine.dart';
import 'package:garir_khata/features/reminders/application/use_cases/reminder_actions.dart';
import 'package:garir_khata/features/reminders/application/use_cases/upsert_reminder.dart';
import 'package:garir_khata/features/reminders/data/local_notification_scheduler.dart';
import 'package:garir_khata/features/reminders/data/repositories/drift_reminder_repository.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final notificationSchedulerProvider = Provider<NotificationScheduler>((ref) {
  return LocalNotificationScheduler();
});

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return DriftReminderRepository(ref.watch(appDatabaseProvider));
});

final reminderEngineProvider = Provider<ReminderEngine>((ref) {
  return ReminderEngine(
    reminderRepository: ref.watch(reminderRepositoryProvider),
    vehicleRepository: ref.watch(vehicleRepositoryProvider),
    scheduler: ref.watch(notificationSchedulerProvider),
    clock: ref.watch(clockProvider),
  );
});

final upsertReminderProvider = Provider<UpsertReminder>((ref) {
  return UpsertReminder(
    repository: ref.watch(reminderRepositoryProvider),
    engine: ref.watch(reminderEngineProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final reminderActionsProvider = Provider<ReminderActions>((ref) {
  return ReminderActions(
    repository: ref.watch(reminderRepositoryProvider),
    engine: ref.watch(reminderEngineProvider),
    scheduler: ref.watch(notificationSchedulerProvider),
    clock: ref.watch(clockProvider),
  );
});

class ReminderFilterNotifier extends Notifier<ReminderStatus?> {
  @override
  ReminderStatus? build() => null;

  void setFilter(ReminderStatus? status) => state = status;
}

final reminderFilterProvider =
    NotifierProvider<ReminderFilterNotifier, ReminderStatus?>(
  ReminderFilterNotifier.new,
);

final selectedVehicleRemindersProvider =
    FutureProvider<List<Reminder>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final ReminderStatus? filter = ref.watch(reminderFilterProvider);
  final includeTerminal = filter == ReminderStatus.completed ||
      filter == ReminderStatus.skipped;
  final Result<List<Reminder>> result =
      await ref.watch(reminderRepositoryProvider).getForVehicle(
            vehicle.id,
            status: filter,
            includeTerminal: includeTerminal || filter == null,
          );
  return result.when(
    success: (reminders) {
      if (filter == null) {
        return reminders
            .where((r) => !r.isTerminal)
            .toList();
      }
      return reminders;
    },
    failure: (error) => throw error,
  );
});

final reminderByIdProvider =
    FutureProvider.family<Reminder?, String>((ref, id) async {
  final Result<Reminder?> result =
      await ref.watch(reminderRepositoryProvider).getById(id);
  return result.when(
    success: (reminder) => reminder,
    failure: (error) => throw error,
  );
});

final upcomingDashboardRemindersProvider =
    FutureProvider<List<Reminder>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  // Re-evaluate when vehicle odometer changes.
  ref.watch(selectedVehicleProvider);
  final Result<List<Reminder>> evaluated =
      await ref.watch(reminderEngineProvider).evaluateForVehicle(vehicle.id);
  return evaluated.when(
    success: (reminders) {
      final attention = reminders
          .where(
            (r) =>
                r.status == ReminderStatus.dueSoon ||
                r.status == ReminderStatus.due ||
                r.status == ReminderStatus.overdue,
          )
          .toList();
      attention.sort((a, b) {
        final int rank = _rank(b.status) - _rank(a.status);
        if (rank != 0) {
          return rank;
        }
        return (a.dueDate ?? DateTime(9999))
            .compareTo(b.dueDate ?? DateTime(9999));
      });
      return attention;
    },
    failure: (error) => throw error,
  );
});

int _rank(ReminderStatus status) => switch (status) {
      ReminderStatus.overdue => 3,
      ReminderStatus.due => 2,
      ReminderStatus.dueSoon => 1,
      _ => 0,
    };
