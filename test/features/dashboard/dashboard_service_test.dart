import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_service.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/data/fuel_expense_link_service.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DashboardService dashboard;
  late Vehicle vehicle;
  late AddFuelEntry addFuel;
  late AddExpense addExpense;
  late DriftExpenseRepository expenseRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    expenseRepo = DriftExpenseRepository(db);
    final link = DriftFuelExpenseLinkService(
      expenseRepository: expenseRepo,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    addFuel = AddFuelEntry(
      fuelRepository: DriftFuelRepository(db),
      odometerRepository: DriftOdometerRepository(db),
      expenseLink: link,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    addExpense = AddExpense(
      repository: expenseRepo,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    dashboard = DashboardService(
      fuelRepository: DriftFuelRepository(db),
      expenseRepository: expenseRepo,
      odometerRepository: DriftOdometerRepository(db),
    );

    final created = await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Dash',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 24000,
      ),
    );
    vehicle = created.dataOrNull!;
  });

  tearDown(() async {
    await db.close();
  });

  test('empty dashboard has no mileage and zero expenses', () async {
    final summary =
        (await dashboard.getSummary(vehicle: vehicle)).dataOrNull!;
    expect(summary.expenses.totalPaisa, 0);
    expect(summary.mileage.status, MileageStatus.insufficientData);
  });

  test('two full tanks show mileage on dashboard', () async {
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 1),
        odometer: 24000,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1300,
      ),
    );
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 8),
        odometer: 24416,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1300,
      ),
    );

    final refreshed = (await DriftVehicleRepository(db).getById(vehicle.id))
        .dataOrNull!;
    final summary =
        (await dashboard.getSummary(vehicle: refreshed, month: DateTime(2026, 10)))
            .dataOrNull!;
    expect(summary.mileage.status, MileageStatus.available);
    expect(summary.mileage.averageMileageKmPerLiter, closeTo(41.6, 0.01));
    expect(summary.expenses.fuelPaisa, 260000);
  });

  test('manual expense increases monthly total', () async {
    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 5),
        categoryId: repair.id,
        amountMajor: 800,
      ),
    );

    final summary =
        (await dashboard.getSummary(vehicle: vehicle, month: DateTime(2026, 10)))
            .dataOrNull!;
    expect(summary.expenses.repairPaisa, 80000);
    expect(summary.expenses.totalPaisa, 80000);
  });
}
