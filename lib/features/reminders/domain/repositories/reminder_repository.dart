import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';

abstract interface class ReminderRepository {
  Future<Result<List<Reminder>>> getForVehicle(
    String vehicleId, {
    ReminderStatus? status,
    bool includeTerminal = false,
  });
  Future<Result<List<Reminder>>> getActive(String vehicleId);
  Future<Result<List<Reminder>>> getAllActive();
  Future<Result<Reminder?>> getById(String id);
  Future<Result<Reminder?>> findByRelated({
    required String relatedEntityType,
    required String relatedEntityId,
  });
  Future<Result<Reminder>> create(Reminder reminder);
  Future<Result<Reminder>> update(Reminder reminder);
  Future<Result<void>> delete(String id);
}
