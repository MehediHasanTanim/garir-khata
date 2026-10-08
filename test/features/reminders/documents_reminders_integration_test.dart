import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/documents/application/use_cases/add_document.dart';
import 'package:garir_khata/features/documents/data/repositories/drift_document_repository.dart';
import 'package:garir_khata/features/documents/domain/document_types.dart';
import 'package:garir_khata/features/reminders/application/reminder_engine.dart';
import 'package:garir_khata/features/reminders/data/repositories/drift_reminder_repository.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftDocumentRepository documents;
  late DriftReminderRepository reminders;
  late DriftVehicleRepository vehicles;
  late InMemoryNotificationScheduler scheduler;
  late ReminderEngine engine;
  late String vehicleId;
  const uuid = DefaultUuidGenerator();
  const clock = SystemClock();

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    documents = DriftDocumentRepository(db);
    reminders = DriftReminderRepository(db);
    vehicles = DriftVehicleRepository(db);
    scheduler = InMemoryNotificationScheduler();
    engine = ReminderEngine(
      reminderRepository: reminders,
      vehicleRepository: vehicles,
      scheduler: scheduler,
      clock: clock,
    );

    final created = await AddVehicle(
      repository: vehicles,
      uuidGenerator: uuid,
      clock: clock,
    )(
      const VehicleInput(
        nickname: 'Doc Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 20000,
      ),
    );
    vehicleId = created.dataOrNull!.id;
  });

  tearDown(() async {
    await db.close();
  });

  test('add insurance creates reminder and schedules notification', () async {
    final add = AddDocument(
      documentRepository: documents,
      reminderRepository: reminders,
      reminderEngine: engine,
      uuidGenerator: uuid,
      clock: clock,
    );
    final result = await add(
      DocumentInput(
        vehicleId: vehicleId,
        documentType: DocumentTypes.insurance,
        documentNumber: 'POL-1',
        policyNumber: 'INS-99',
        providerName: 'Green Delta',
        expiryDate: DateTime.now().add(const Duration(days: 20)),
        createExpiryReminder: true,
        advanceDays: 30,
      ),
    );
    expect(result.isSuccess, isTrue);

    final active = await reminders.getActive(vehicleId);
    expect(active.dataOrNull, hasLength(1));
    expect(active.dataOrNull!.first.relatedEntityType, ReminderEntityType.document);
    expect(active.dataOrNull!.first.status, ReminderStatus.dueSoon);
    expect(scheduler.scheduled.containsKey(active.dataOrNull!.first.id), isTrue);
  });

  test('high odometer fuel path makes service reminder due', () async {
    final now = DateTime.now();
    final Reminder reminder = Reminder(
      id: uuid.v4(),
      vehicleId: vehicleId,
      reminderType: ReminderKind.odometer,
      title: 'General service',
      dueOdometer: 20500,
      advanceDays: 30,
      advanceKm: 500,
      recurrenceType: ReminderRecurrence.none,
      status: ReminderStatus.upcoming,
      notificationEnabled: true,
      createdAt: now,
      updatedAt: now,
    );
    await reminders.create(reminder);

    // Simulate odometer bump after fuel save.
    final vehicle = (await vehicles.getById(vehicleId)).dataOrNull!;
    await vehicles.upsert(
      vehicle.copyWith(currentOdometer: 20600, updatedAt: now),
    );

    final evaluated = await engine.evaluateForVehicle(vehicleId);
    expect(evaluated.isSuccess, isTrue);
    expect(evaluated.dataOrNull!.first.status, ReminderStatus.overdue);
    expect(scheduler.scheduled.containsKey(reminder.id), isTrue);
  });
}
