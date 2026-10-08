import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/data/fuel_expense_link_service.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftExpenseRepository expenses;
  late String vehicleId;
  late DriftFuelExpenseLinkService link;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    expenses = DriftExpenseRepository(db);
    link = DriftFuelExpenseLinkService(
      expenseRepository: expenses,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );

    final addVehicle = AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    final vehicle = await addVehicle(
      const VehicleInput(
        nickname: 'Dash Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 24000,
      ),
    );
    vehicleId = vehicle.dataOrNull!.id;
  });

  tearDown(() async {
    await db.close();
  });

  test('seeds system expense categories', () async {
    final cats = await expenses.getCategories();
    expect(cats.isSuccess, isTrue);
    expect(cats.dataOrNull!.length, ExpenseCategorySeeds.all.length);
    expect(
      cats.dataOrNull!.any((c) => c.code == ExpenseCategoryCodes.fuel),
      isTrue,
    );
  });

  test('manual expense changes monthly aggregation', () async {
    final maintenance = (await expenses.getCategoryByCode(
      ExpenseCategoryCodes.maintenance,
    )).dataOrNull!;
    final add = AddExpense(
      repository: expenses,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    await add(
      ExpenseInput(
        vehicleId: vehicleId,
        occurredOn: DateTime.now(),
        categoryId: maintenance.id,
        amountMajor: 1200,
      ),
    );

    final sum = await expenses.sumAmountPaisa(
      vehicleId: vehicleId,
      from: DateTime(DateTime.now().year, DateTime.now().month),
      to: DateTime(DateTime.now().year, DateTime.now().month + 1),
      dashboardGroup: ExpenseDashboardGroups.maintenance,
    );
    expect(sum.dataOrNull, 120000);
  });

  test('fuel linkage creates one expense and updates without duplicates', () async {
    final addFuel = AddFuelEntry(
      fuelRepository: DriftFuelRepository(db),
      odometerRepository: DriftOdometerRepository(db),
      expenseLink: link,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );

    final first = await addFuel(
      FuelInput(
        vehicleId: vehicleId,
        dateTime: DateTime(2026, 10, 8, 10),
        odometer: 24830,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1300,
        stationName: 'Padma',
      ),
    );
    expect(first.isSuccess, isTrue);
    final String fuelId = first.dataOrNull!.entry.id;

    final linked = await expenses.findBySource(
      sourceType: ExpenseSourceType.fuel,
      sourceRecordId: fuelId,
    );
    expect(linked.dataOrNull, isNotNull);
    expect(linked.dataOrNull!.amountPaisa, 130000);

    await link.upsertLinkedExpense(
      FuelValidator.validate(
        FuelInput(
          vehicleId: vehicleId,
          dateTime: DateTime(2026, 10, 8, 10),
          odometer: 24830,
          fuelType: FuelType.petrol,
          isFullTank: true,
          liters: 10,
          totalMajor: 1400,
          stationName: 'Padma',
        ),
      ).dataOrNull!,
      fuelId,
    );

    final history = await expenses.getHistory(vehicleId);
    final fuelLinked = history.dataOrNull!
        .where((e) => e.sourceType == ExpenseSourceType.fuel)
        .toList();
    expect(fuelLinked, hasLength(1));
    expect(fuelLinked.first.amountPaisa, 140000);
  });
}
