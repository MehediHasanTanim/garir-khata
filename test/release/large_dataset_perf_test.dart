import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/backup/backup_service.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/release/release_info.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_service.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/history/data/repositories/drift_timeline_repository.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/reports/data/repositories/drift_report_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:path/path.dart' as p;

/// Sprint 11 §16.3 — seed a large dataset and assert query budgets.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('large dataset dashboard / timeline / reports / backup budgets', () async {
    final temp = await Directory.systemTemp.createTemp('gk_large_');
    addTearDown(() async {
      if (await temp.exists()) {
        await temp.delete(recursive: true);
      }
    });

    final dbFile = File(p.join(temp.path, 'large.sqlite'));
    final db = AppDatabase(NativeDatabase(dbFile));
    addTearDown(db.close);

    const uuid = DefaultUuidGenerator();
    final now = DateTime.utc(2026, 10, 1);
    final vehicleIds = <String>[];

    // Multiple vehicles
    for (var i = 0; i < 4; i++) {
      final id = uuid.v4();
      vehicleIds.add(id);
      await db.into(db.vehicles).insert(
            VehiclesCompanion.insert(
              id: id,
              nickname: 'Bike $i',
              vehicleType: 'motorcycle',
              fuelType: 'petrol',
              currentOdometer: Value(50000 + i * 1000),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    final primary = vehicleIds.first;
    final parking = await (db.select(db.expenseCategories)
          ..where((t) => t.code.equals(ExpenseCategoryCodes.parking)))
        .getSingle();

    // ~5 years of fuel (~60/year) + expenses + services for primary vehicle
    const fuelCount = 3000;
    const expenseCount = 3000;
    const serviceCount = 400;

    await db.batch((batch) {
      for (var i = 0; i < fuelCount; i++) {
        final day = DateTime.utc(2021, 1, 1).add(Duration(days: i ~/ 2));
        final id = 'fuel-$i';
        final odo = 10000 + i * 35;
        batch.insert(
          db.fuelEntries,
          FuelEntriesCompanion.insert(
            id: id,
            vehicleId: primary,
            entryDateTime: day,
            odometer: odo,
            fuelType: 'petrol',
            quantityMl: 10000,
            totalCostPaisa: 130000,
            isFullTank: const Value(true),
            createdAt: day,
            updatedAt: day,
          ),
        );
      }
      for (var i = 0; i < expenseCount; i++) {
        final day = DateTime.utc(2021, 1, 1).add(Duration(days: i ~/ 2));
        batch.insert(
          db.expenses,
          ExpensesCompanion.insert(
            id: 'exp-$i',
            vehicleId: primary,
            occurredOn: day,
            categoryId: parking.id,
            amountPaisa: 5000,
            sourceType: const Value('manual'),
            createdAt: day,
            updatedAt: day,
          ),
        );
      }
      for (var i = 0; i < serviceCount; i++) {
        final day = DateTime.utc(2021, 1, 1).add(Duration(days: i * 5));
        batch.insert(
          db.serviceRecords,
          ServiceRecordsCompanion.insert(
            id: 'svc-$i',
            vehicleId: primary,
            serviceDate: day,
            odometer: 12000 + i * 100,
            laborCostPaisa: const Value(10000),
            partsCostPaisa: const Value(20000),
            totalCostPaisa: const Value(30000),
            createdAt: day,
            updatedAt: day,
          ),
        );
      }
    });

    final vehicle = Vehicle(
      id: primary,
      nickname: 'Bike 0',
      vehicleType: VehicleType.motorcycle,
      fuelType: FuelType.petrol,
      currentOdometer: 10000 + fuelCount * 35,
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );

    final dashboard = DashboardService(
      fuelRepository: DriftFuelRepository(db),
      expenseRepository: DriftExpenseRepository(db),
      odometerRepository: DriftOdometerRepository(db),
      reportRepository: DriftReportRepository(db),
    );
    final timeline = DriftTimelineRepository(db);
    final reports = DriftReportRepository(db);

    Future<Duration> timed(Future<void> Function() body) async {
      final sw = Stopwatch()..start();
      await body();
      sw.stop();
      return sw.elapsed;
    }

    final dashMs = await timed(() async {
      final r = await dashboard.getSummary(vehicle: vehicle);
      expect(r.isSuccess, isTrue);
    });
    final timelineMs = await timed(() async {
      final r = await timeline.getPage(vehicleId: primary, limit: 50);
      expect(r.isSuccess, isTrue);
      expect(r.dataOrNull!.items, isNotEmpty);
    });
    final reportMs = await timed(() async {
      final r = await reports.yearlyExpenses(vehicleId: primary, year: 2024);
      expect(r.isSuccess, isTrue);
    });

    // Generous CI budgets (local machines vary).
    expect(dashMs.inMilliseconds, lessThan(5000));
    expect(timelineMs.inMilliseconds, lessThan(5000));
    expect(reportMs.inMilliseconds, lessThan(8000));

    final storage = FileStorageService(
      rootDirectory: Directory(p.join(temp.path, 'data')),
      uuidGenerator: uuid,
    );
    await storage.ensureReady();
    final backed = await BackupService(
      db: db,
      storage: storage,
      uuidGenerator: uuid,
      clock: const SystemClock(),
      appVersion: ReleaseInfo.versionLabel,
      snapshotDatabase: (dir) async {
        await db.customStatement('PRAGMA wal_checkpoint(FULL)');
        final dest = File(p.join(dir.path, 'database.sqlite'));
        await dbFile.copy(dest.path);
        return dest;
      },
    ).createBackup(
      includeAttachments: false,
      outputDirectory: Directory(p.join(temp.path, 'out')),
    );
    expect(backed.isSuccess, isTrue);
    final size = await File(backed.dataOrNull!.filePath).length();
    // Compressed DB of thousands of rows should stay under ~15MB without attachments.
    expect(size, lessThan(15 * 1024 * 1024));
    expect(size, greaterThan(10 * 1024));
  }, timeout: const Timeout(Duration(minutes: 3)));
}
