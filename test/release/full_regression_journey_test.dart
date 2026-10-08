import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/backup/backup_service.dart';
import 'package:garir_khata/core/backup/restore_service.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/database/seeds/maintenance_template_seeds.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/release/release_info.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_service.dart';
import 'package:garir_khata/features/documents/application/use_cases/add_document.dart';
import 'package:garir_khata/features/documents/data/repositories/drift_document_repository.dart';
import 'package:garir_khata/features/documents/domain/document_types.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/data/fuel_expense_link_service.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/history/data/repositories/drift_timeline_repository.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/add_service.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/record_oil_change.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_oil_repository.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_service_repository.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/validation/oil_validator.dart';
import 'package:garir_khata/features/maintenance/domain/validation/service_validator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_calculator.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/parts/application/use_cases/add_repair.dart';
import 'package:garir_khata/features/parts/data/repair_expense_link.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_repair_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_tyre_repository.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/domain/validation/repair_validator.dart';
import 'package:garir_khata/features/reminders/application/reminder_engine.dart';
import 'package:garir_khata/features/reminders/data/repositories/drift_reminder_repository.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:garir_khata/features/reports/data/repositories/drift_report_repository.dart';
import 'package:garir_khata/features/settings/data/secure_credentials_store.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

/// Sprint 11 §16.1 — service-level end-to-end regression of core journeys.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('full regression journey from motorcycle to backup/PIN', () async {
    expect(ReleaseInfo.databaseSchemaVersion, 7);
    expect(ReleaseInfo.backupFormatVersion, 1);

    final temp = await Directory.systemTemp.createTemp('gk_regression_');
    addTearDown(() async {
      if (await temp.exists()) {
        await temp.delete(recursive: true);
      }
    });

    final dbFile = File(p.join(temp.path, 'live.sqlite'));
    var db = AppDatabase(NativeDatabase(dbFile));
    final storage = FileStorageService(
      rootDirectory: Directory(p.join(temp.path, 'data')),
      uuidGenerator: const DefaultUuidGenerator(),
    );
    await storage.ensureReady();

    const uuid = DefaultUuidGenerator();
    const clock = SystemClock();
    final vehicles = DriftVehicleRepository(db);
    final expenses = DriftExpenseRepository(db);
    final fuelRepo = DriftFuelRepository(db);
    final odoRepo = DriftOdometerRepository(db);
    final fuelLink = DriftFuelExpenseLinkService(
      expenseRepository: expenses,
      uuidGenerator: uuid,
      clock: clock,
    );
    final addFuel = AddFuelEntry(
      fuelRepository: fuelRepo,
      odometerRepository: odoRepo,
      expenseLink: fuelLink,
      uuidGenerator: uuid,
      clock: clock,
    );
    final serviceLink = ServiceExpenseLink(
      expenseRepository: expenses,
      uuidGenerator: uuid,
      clock: clock,
    );
    final services = DriftServiceRepository(db);
    final oils = DriftOilRepository(db);
    final repairs = DriftRepairRepository(db);
    final repairLink = RepairExpenseLink(
      expenseRepository: expenses,
      uuidGenerator: uuid,
      clock: clock,
    );
    final tyres = DriftTyreRepository(db);
    final documents = DriftDocumentRepository(db);
    final reminders = DriftReminderRepository(db);
    final scheduler = InMemoryNotificationScheduler();
    final engine = ReminderEngine(
      reminderRepository: reminders,
      vehicleRepository: vehicles,
      scheduler: scheduler,
      clock: clock,
    );
    final dashboard = DashboardService(
      fuelRepository: fuelRepo,
      expenseRepository: expenses,
      odometerRepository: odoRepo,
      reportRepository: DriftReportRepository(db),
    );
    final timeline = DriftTimelineRepository(db);
    final reports = DriftReportRepository(db);

    final today = DateTime.now();
    final day1 = today.subtract(const Duration(days: 20));
    final day2 = today.subtract(const Duration(days: 5));

    // 1–3 Create motorcycle (Bangla nickname stands in for locale preference).
    final vehicle = (await AddVehicle(
      repository: vehicles,
      uuidGenerator: uuid,
      clock: clock,
    )(
      VehicleInput(
        nickname: 'হর্নেট',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 24000,
      ),
    )).dataOrNull!;

    // 4–6 Fuel + mileage
    expect(
      (await addFuel(
        FuelInput(
          vehicleId: vehicle.id,
          dateTime: day1,
          odometer: 24000,
          fuelType: FuelType.petrol,
          isFullTank: true,
          liters: 10,
          totalMajor: 1300,
        ),
      )).isSuccess,
      isTrue,
    );
    expect(
      (await addFuel(
        FuelInput(
          vehicleId: vehicle.id,
          dateTime: day2,
          odometer: 24420,
          fuelType: FuelType.petrol,
          isFullTank: true,
          liters: 10,
          totalMajor: 1350,
        ),
      )).isSuccess,
      isTrue,
    );
    final fuels = (await fuelRepo.getHistory(vehicle.id)).dataOrNull!;
    final mileage = MileageCalculator.calculateIntervals(fuels);
    expect(mileage, isNotEmpty);
    expect(mileage.first.mileageKmPerLiter, closeTo(42.0, 0.1));

    // 7 Expense
    final parking = (await expenses.getCategoryByCode(
      ExpenseCategoryCodes.parking,
    )).dataOrNull!;
    expect(
      (await AddExpense(repository: expenses, uuidGenerator: uuid, clock: clock)(
        ExpenseInput(
          vehicleId: vehicle.id,
          occurredOn: today.subtract(const Duration(days: 2)),
          categoryId: parking.id,
          amountMajor: 50,
          description: 'Parking',
        ),
      )).isSuccess,
      isTrue,
    );

    // 8 Service
    expect(
      (await AddService(
        repository: services,
        expenseLink: serviceLink,
        uuidGenerator: uuid,
        clock: clock,
      )(
        ServiceInput(
          vehicleId: vehicle.id,
          serviceDate: today.subtract(const Duration(days: 4)),
          odometer: 24500,
          laborMajor: 400,
          partsMajor: 600,
          items: const [
            ServiceItemInput(
              title: 'Chain',
              maintenanceType: MaintenanceTemplateCodes.chainLubrication,
              costMajor: 600,
            ),
          ],
        ),
      )).isSuccess,
      isTrue,
    );

    // 9 Engine oil
    expect(
      (await RecordOilChange(
        oilRepository: oils,
        serviceRepository: services,
        expenseLink: serviceLink,
        uuidGenerator: uuid,
        clock: clock,
      )(
        input: OilChangeInput(
          vehicleId: vehicle.id,
          occurredOn: today.subtract(const Duration(days: 3)),
          odometer: 24600,
          brand: 'Motul',
          quantityLiters: 1.1,
          costMajor: 1400,
          filterChanged: true,
        ),
        vehicleType: VehicleType.motorcycle,
      )).isSuccess,
      isTrue,
    );

    // 10 Repair
    expect(
      (await AddRepair(
        repository: repairs,
        expenseLink: repairLink,
        uuidGenerator: uuid,
        clock: clock,
      )(
        RepairInput(
          vehicleId: vehicle.id,
          repairDate: today.subtract(const Duration(days: 1)),
          odometer: 24800,
          category: 'electrical',
          problemDescription: 'Horn weak',
          laborMajor: 200,
        ),
      )).isSuccess,
      isTrue,
    );

    // 11 Tyre
    final tyreId = uuid.v4();
    final now = today;
    expect(
      (await tyres.create(
        Tyre(
          id: tyreId,
          vehicleId: vehicle.id,
          position: TyrePosition.rear,
          brand: 'MRF',
          installDate: now,
          installOdometer: 24850,
          costPaisa: 350000,
          status: TyreStatus.active,
          createdAt: now,
          updatedAt: now,
        ),
        installEvent: TyreEvent(
          id: uuid.v4(),
          tyreId: tyreId,
          vehicleId: vehicle.id,
          eventType: TyreEventType.installed,
          occurredOn: now,
          odometer: 24850,
          toPosition: TyrePosition.rear,
          createdAt: now,
        ),
      )).isSuccess,
      isTrue,
    );

    // 12–13 Insurance + reminder
    expect(
      (await AddDocument(
        documentRepository: documents,
        reminderRepository: reminders,
        reminderEngine: engine,
        uuidGenerator: uuid,
        clock: clock,
      )(
        DocumentInput(
          vehicleId: vehicle.id,
          documentType: DocumentTypes.insurance,
          documentNumber: 'POL-REG',
          policyNumber: 'INS-1',
          providerName: 'Green Delta',
          expiryDate: today.add(const Duration(days: 25)),
          createExpiryReminder: true,
          advanceDays: 30,
        ),
      )).isSuccess,
      isTrue,
    );
    final activeReminders = (await reminders.getActive(vehicle.id)).dataOrNull!;
    expect(activeReminders, isNotEmpty);

    // 14 Reports / dashboard / timeline
    final refreshed = (await vehicles.getById(vehicle.id)).dataOrNull!;
    final summary = (await dashboard.getSummary(vehicle: refreshed)).dataOrNull!;
    expect(summary.hasAnyData, isTrue);
    expect(summary.expenses.totalPaisa, greaterThan(0));
    final page = (await timeline.getPage(vehicleId: vehicle.id, limit: 50))
        .dataOrNull!;
    expect(page.items, isNotEmpty);
    final monthly = (await reports.monthlyExpenses(
      vehicleId: vehicle.id,
      monthStart: DateTime(today.year, today.month),
    )).dataOrNull!;
    expect(monthly.totalPaisa, greaterThan(0));

    // 15–16 Backup + restore
    late BackupService backup;
    late RestoreService restore;

    backup = BackupService(
      db: db,
      storage: storage,
      uuidGenerator: uuid,
      clock: clock,
      appVersion: ReleaseInfo.versionLabel,
      snapshotDatabase: (dir) async {
        await db.customStatement('PRAGMA wal_checkpoint(FULL)');
        final dest = File(p.join(dir.path, 'database.sqlite'));
        await dbFile.copy(dest.path);
        return dest;
      },
    );
    restore = RestoreService(
      db: db,
      storage: storage,
      backupService: backup,
      uuidGenerator: uuid,
      clock: clock,
      replaceDatabase: (restored) async {
        await db.close();
        await restored.copy(dbFile.path);
        db = AppDatabase(NativeDatabase(dbFile));
        backup = BackupService(
          db: db,
          storage: storage,
          uuidGenerator: uuid,
          clock: clock,
          appVersion: ReleaseInfo.versionLabel,
          snapshotDatabase: (dir) async {
            final dest = File(p.join(dir.path, 'database.sqlite'));
            await dbFile.copy(dest.path);
            return dest;
          },
        );
        restore = RestoreService(
          db: db,
          storage: storage,
          backupService: backup,
          uuidGenerator: uuid,
          clock: clock,
          replaceDatabase: (_) async {},
        );
      },
    );

    final image = img.Image(width: 8, height: 8);
    img.fill(image, color: img.ColorRgb8(10, 20, 30));
    await storage.storeBytes(
      bytes: Uint8List.fromList(img.encodePng(image)),
      originalFileName: 'receipt.png',
      ownerType: 'fuel',
    );

    final backed = await backup.createBackup(
      password: 'secret-pass',
      includeAttachments: true,
      outputDirectory: Directory(p.join(temp.path, 'out')),
    );
    expect(backed.isSuccess, isTrue);
    final envelope =
        await File(backed.dataOrNull!.filePath).readAsBytes();

    final restored = await restore.restore(
      envelope: Uint8List.fromList(envelope),
      password: 'secret-pass',
      createSafetyBackup: false,
    );
    expect(restored.dataOrNull!.phase.name, 'success');

    final after = AppDatabase(NativeDatabase(dbFile));
    addTearDown(after.close);
    final vehicleCount = await after.select(after.vehicles).get();
    expect(vehicleCount, isNotEmpty);

    // 17 Enable PIN
    final pins = SecureCredentialsStore(storage: MemorySecureKeyValueStore());
    await pins.setPin('2468');
    expect(await pins.verifyPin('2468'), isTrue);
    expect(await pins.verifyPin('0000'), isFalse);
  });
}
