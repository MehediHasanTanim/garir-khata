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
import 'package:garir_khata/features/history/data/repositories/drift_timeline_repository.dart';
import 'package:garir_khata/features/history/domain/timeline_item.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftTimelineRepository timeline;
  late Vehicle vehicle;
  late AddFuelEntry addFuel;
  late AddExpense addExpense;
  late DriftExpenseRepository expenseRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    timeline = DriftTimelineRepository(db);
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
    vehicle = (await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Timeline',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 5000,
      ),
    )).dataOrNull!;
  });

  tearDown(() async {
    await db.close();
  });

  test('unified timeline mixes fuel and expenses with type filter', () async {
    await addFuel(
      FuelInput(
        vehicleId: vehicle.id,
        dateTime: DateTime(2026, 10, 1),
        odometer: 5000,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 5,
        totalMajor: 650,
        stationName: 'Padma Pump',
      ),
    );
    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    await addExpense(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 2),
        categoryId: repair.id,
        amountMajor: 300,
        description: 'Brake job',
      ),
    );

    final all = (await timeline.getPage(vehicleId: vehicle.id)).dataOrNull!;
    expect(all.items.length, greaterThanOrEqualTo(2));

    final fuelOnly = (await timeline.getPage(
      vehicleId: vehicle.id,
      types: {TimelineItemType.fuel},
    )).dataOrNull!;
    expect(fuelOnly.items.every((i) => i.type == TimelineItemType.fuel), isTrue);

    final searched = (await timeline.getPage(
      vehicleId: vehicle.id,
      search: 'brake',
    )).dataOrNull!;
    expect(searched.items, isNotEmpty);
    expect(
      searched.items.any((i) => i.title.toLowerCase().contains('brake') ||
          (i.searchText?.contains('brake') ?? false)),
      isTrue,
    );
  });
}
