import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/data/fuel_expense_link_service.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/parts/application/use_cases/add_repair.dart';
import 'package:garir_khata/features/parts/data/repair_expense_link.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_repair_repository.dart';
import 'package:garir_khata/features/parts/domain/validation/repair_validator.dart';
import 'package:garir_khata/features/reports/data/repositories/drift_report_repository.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftReportRepository reports;
  late Vehicle vehicle;
  late AddFuelEntry addFuel;
  late AddExpense addExpense;
  late DriftExpenseRepository expenseRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    expenseRepo = DriftExpenseRepository(db);
    reports = DriftReportRepository(db);
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

    final created = await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Report Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 10000,
      ),
    );
    vehicle = created.dataOrNull!;
  });

  tearDown(() async {
    await db.close();
  });

  test('monthly totals split fuel maintenance repair documents other', () async {
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 2),
        odometer: 10000,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 5,
        totalMajor: 650,
      ),
    );
    final maint = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.maintenance,
    )).dataOrNull!;
    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    final tax = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.taxToken,
    )).dataOrNull!;
    final other = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.other,
    )).dataOrNull!;

    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 3),
        categoryId: maint.id,
        amountMajor: 500,
      ),
    );
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 4),
        categoryId: repair.id,
        amountMajor: 800,
      ),
    );
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 5),
        categoryId: tax.id,
        amountMajor: 200,
      ),
    );
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 6),
        categoryId: other.id,
        amountMajor: 100,
      ),
    );

    final report = (await reports.monthlyExpenses(
      vehicleId: vehicle.id,
      monthStart: DateTime(2026, 10),
    )).dataOrNull!;

    expect(report.fuelPaisa, 65000);
    expect(report.maintenancePaisa, 50000);
    expect(report.repairPaisa, 80000);
    expect(report.documentsPaisa, 20000);
    expect(report.otherPaisa, 10000);
    expect(report.totalPaisa, 225000);
  });

  test('yearly category aggregation and highest month', () async {
    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 1, 10),
        categoryId: repair.id,
        amountMajor: 100,
      ),
    );
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 3, 10),
        categoryId: repair.id,
        amountMajor: 400,
      ),
    );

    final yearly = (await reports.yearlyExpenses(
      vehicleId: vehicle.id,
      year: 2026,
    )).dataOrNull!;

    expect(yearly.annualTotalPaisa, 50000);
    expect(yearly.highestMonth, 3);
    expect(yearly.highestMonthPaisa, 40000);
    expect(yearly.categoryBreakdown.first.code, ExpenseCategoryCodes.repair);
  });

  test('mileage report after two full tanks', () async {
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 1),
        odometer: 10000,
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
        odometer: 10416,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1300,
      ),
    );

    final mileage = (await reports.mileageReport(
      vehicleId: vehicle.id,
      now: DateTime(2026, 10, 10),
    )).dataOrNull!;

    expect(mileage.isEmpty, isFalse);
    expect(mileage.lifetime.averageMileageKmPerLiter, closeTo(41.6, 0.01));
    expect(mileage.bestKmPerLiter, closeTo(41.6, 0.01));
  });

  test('cost/km handles insufficient distance safely', () async {
    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 5),
        categoryId: repair.id,
        amountMajor: 500,
      ),
    );

    final report = (await reports.costPerKmReport(
      vehicleId: vehicle.id,
      from: DateTime(2026, 10),
      to: DateTime(2026, 11),
      mode: CostPerKmMode.operating,
    )).dataOrNull!;

    expect(report.result.status, CostPerKmStatus.notEnoughData);
    expect(report.result.costPerKmPaisa, isNull);
    expect(report.formulaExplanation, isNotEmpty);
  });

  test('cost/km fuel-only with distance', () async {
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 1),
        odometer: 10000,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1000,
      ),
    );
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 8),
        odometer: 10100,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1000,
      ),
    );

    final report = (await reports.costPerKmReport(
      vehicleId: vehicle.id,
      from: DateTime(2026, 10),
      to: DateTime(2026, 11),
      mode: CostPerKmMode.fuelOnly,
    )).dataOrNull!;

    expect(report.result.isAvailable, isTrue);
    expect(report.result.distanceKm, 100);
    expect(report.result.costPerKmMajor, closeTo(20.0, 0.01));
  });

  test('repair report detects repeated categories', () async {
    final repairRepo = DriftRepairRepository(db);
    final addRepair = AddRepair(
      repository: repairRepo,
      expenseLink: RepairExpenseLink(
        expenseRepository: expenseRepo,
        uuidGenerator: const DefaultUuidGenerator(),
        clock: const SystemClock(),
      ),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );

    for (var i = 0; i < 3; i++) {
      await addRepair(
        RepairInput(
          vehicleId: vehicle.id,
          repairDate: DateTime(2026, 10, i + 1),
          odometer: 10000 + i,
          category: 'engine',
          problemDescription: 'Engine issue $i',
          laborMajor: 200,
        ),
      );
    }

    final report = (await reports.repairReport(
      vehicleId: vehicle.id,
      from: DateTime(2026),
      to: DateTime(2027),
      repeatThreshold: 2,
    )).dataOrNull!;

    expect(report.repairCount, 3);
    expect(report.repeatedCategories, isNotEmpty);
    expect(report.repeatedCategories.first.count, 3);
  });
}
