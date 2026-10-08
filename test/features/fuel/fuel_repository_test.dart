import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/application/use_cases/delete_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftFuelRepository fuelRepository;
  late DriftOdometerRepository odometerRepository;
  late AddFuelEntry addFuel;
  late DeleteFuelEntry deleteFuel;
  late String vehicleId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    fuelRepository = DriftFuelRepository(db);
    odometerRepository = DriftOdometerRepository(db);
    addFuel = AddFuelEntry(
      fuelRepository: fuelRepository,
      odometerRepository: odometerRepository,
      expenseLink: const NoOpFuelExpenseLinkService(),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    deleteFuel = DeleteFuelEntry(
      fuelRepository: fuelRepository,
      expenseLink: const NoOpFuelExpenseLinkService(),
    );

    final AddVehicle addVehicle = AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    final vehicleResult = await addVehicle(
      const VehicleInput(
        nickname: 'My Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 24000,
      ),
    );
    vehicleId = vehicleResult.dataOrNull!.id;
  });

  tearDown(() async {
    await db.close();
  });

  test('add fuel updates vehicle odometer atomically', () async {
    final Result<AddFuelResult> result = await addFuel(
      FuelInput(
        vehicleId: vehicleId,
        dateTime: DateTime(2026, 10, 8, 10),
        odometer: 24830,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 12.6,
        totalMajor: 1638,
      ),
    );
    expect(result.isSuccess, isTrue);

    final vehicle = await (db.select(db.vehicles)
          ..where((t) => t.id.equals(vehicleId)))
        .getSingle();
    expect(vehicle.currentOdometer, 24830);

    final odo = await (db.select(db.odometerEntries)
          ..where((t) => t.vehicleId.equals(vehicleId)))
        .get();
    expect(odo.length, 2); // onboarding + fuel
  });

  test('delete latest fuel recalculates vehicle odometer', () async {
    final created = await addFuel(
      FuelInput(
        vehicleId: vehicleId,
        dateTime: DateTime(2026, 10, 8, 10),
        odometer: 24830,
        fuelType: FuelType.petrol,
        isFullTank: true,
        liters: 10,
        totalMajor: 1300,
      ),
    );
    final String fuelId = created.dataOrNull!.entry.id;

    final deleted = await deleteFuel(fuelId);
    expect(deleted.isSuccess, isTrue);

    final vehicle = await (db.select(db.vehicles)
          ..where((t) => t.id.equals(vehicleId)))
        .getSingle();
    expect(vehicle.currentOdometer, 24000);
  });

  test('duplicate fuel warning is returned', () async {
    final input = FuelInput(
      vehicleId: vehicleId,
      dateTime: DateTime(2026, 10, 8, 10),
      odometer: 24830,
      fuelType: FuelType.petrol,
      isFullTank: true,
      liters: 10,
      totalMajor: 1300,
    );
    await addFuel(input);
    final second = await addFuel(input);
    expect(second.isFailure, isTrue);
    expect(second.errorOrNull!.code, 'fuel_duplicate');
  });
}
