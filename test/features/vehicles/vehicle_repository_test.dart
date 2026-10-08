import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

void main() {
  late AppDatabase db;
  late DriftVehicleRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftVehicleRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('upsert and getActiveVehicles round-trip', () async {
    final DateTime now = DateTime.utc(2026, 10, 8);
    final Vehicle vehicle = Vehicle(
      id: 'v1',
      nickname: 'My Bike',
      vehicleType: VehicleType.motorcycle,
      fuelType: FuelType.petrol,
      currentOdometer: 1000,
      isArchived: false,
      createdAt: now,
      updatedAt: now,
      brand: 'Yamaha',
      model: 'FZS',
    );

    final Result<Vehicle> saveResult = await repository.upsert(vehicle);
    expect(saveResult.isSuccess, isTrue);

    final Result<List<Vehicle>> listResult = await repository
        .getActiveVehicles();
    expect(listResult.isSuccess, isTrue);
    expect(listResult.dataOrNull!.single.nickname, 'My Bike');
  });

  test('archive excludes vehicle from active list', () async {
    final DateTime now = DateTime.utc(2026, 10, 8);
    await repository.upsert(
      Vehicle(
        id: 'v2',
        nickname: 'Family Car',
        vehicleType: VehicleType.car,
        fuelType: FuelType.octane,
        currentOdometer: 5000,
        isArchived: false,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final Result<void> archiveResult = await repository.archive('v2');
    expect(archiveResult.isSuccess, isTrue);

    final Result<List<Vehicle>> listResult = await repository
        .getActiveVehicles();
    expect(listResult.dataOrNull, isEmpty);
  });
}
