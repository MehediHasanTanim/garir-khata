import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/export/csv_export_service.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/expenses/data/fuel_expense_link_service.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late Directory temp;
  late AppDatabase db;
  late CsvExportService exporter;
  late Vehicle vehicle;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('gk_csv_');
    db = AppDatabase(NativeDatabase.memory());
    exporter = CsvExportService(
      db: db,
      storage: FileStorageService(
        rootDirectory: temp,
        uuidGenerator: const DefaultUuidGenerator(),
      ),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    vehicle = (await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'CSV Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 1000,
      ),
    )).dataOrNull!;

    final expenseRepo = DriftExpenseRepository(db);
    await AddFuelEntry(
      fuelRepository: DriftFuelRepository(db),
      odometerRepository: DriftOdometerRepository(db),
      expenseLink: DriftFuelExpenseLinkService(
        expenseRepository: expenseRepo,
        uuidGenerator: const DefaultUuidGenerator(),
        clock: const SystemClock(),
      ),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 1),
        odometer: 1000,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 5,
        totalMajor: 650,
        stationName: 'পদ্মা পাম্প',
      ),
    );

    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    await AddExpense(
      repository: expenseRepo,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 2),
        categoryId: repair.id,
        amountMajor: 200,
        description: 'মেরামত',
      ),
    );
  });

  tearDown(() async {
    await db.close();
    if (await temp.exists()) {
      await temp.delete(recursive: true);
    }
  });

  test('fuel CSV includes BOM and Bangla station', () async {
    final result = await exporter.export(
      CsvExportRequest(kind: CsvExportKind.fuel, vehicleId: vehicle.id),
    );
    expect(result.isSuccess, isTrue);
    final bytes = result.dataOrNull!.bytes;
    expect(bytes.take(3), CsvExportService.utf8Bom);
    final text = utf8.decode(bytes.sublist(3));
    expect(text, contains('পদ্মা পাম্প'));
    expect(text, contains('5.000'));
    expect(text, contains('650.00'));
  });

  test('expense CSV includes Bangla description', () async {
    final result = await exporter.export(
      CsvExportRequest(kind: CsvExportKind.expenses, vehicleId: vehicle.id),
    );
    final text = utf8.decode(result.dataOrNull!.bytes.sublist(3));
    expect(text, contains('মেরামত'));
    expect(text, contains('200.00'));
  });
}
