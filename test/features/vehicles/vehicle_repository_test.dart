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

  Vehicle buildVehicle({
    required String id,
    required String nickname,
    bool archived = false,
  }) {
    final DateTime now = DateTime.utc(2026, 10, 8);
    return Vehicle(
      id: id,
      nickname: nickname,
      vehicleType: VehicleType.motorcycle,
      fuelType: FuelType.petrol,
      currentOdometer: 1000,
      isArchived: archived,
      createdAt: now,
      updatedAt: now,
      brand: 'Yamaha',
      model: 'FZS',
    );
  }

  test('upsert and getActiveVehicles round-trip', () async {
    final Result<Vehicle> saveResult = await repository.upsert(
      buildVehicle(id: 'v1', nickname: 'My Bike'),
    );
    expect(saveResult.isSuccess, isTrue);

    final Result<List<Vehicle>> listResult = await repository
        .getActiveVehicles();
    expect(listResult.isSuccess, isTrue);
    expect(listResult.dataOrNull!.single.nickname, 'My Bike');
  });

  test('createWithInitialOdometer stores vehicle and odometer entry', () async {
    final Vehicle vehicle = buildVehicle(id: 'v3', nickname: 'Hornet');
    final Result<Vehicle> result = await repository.createWithInitialOdometer(
      vehicle: vehicle,
      odometerEntryId: 'odo-1',
    );
    expect(result.isSuccess, isTrue);

    final odometer = await (db.select(
      db.odometerEntries,
    )..where((t) => t.vehicleId.equals('v3'))).getSingle();
    expect(odometer.odometer, 1000);
    expect(odometer.sourceType, 'manual');
  });

  test('archive excludes vehicle from active list', () async {
    await repository.upsert(buildVehicle(id: 'v2', nickname: 'Family Car'));
    final Result<void> archiveResult = await repository.archive('v2');
    expect(archiveResult.isSuccess, isTrue);

    final Result<List<Vehicle>> listResult = await repository
        .getActiveVehicles();
    expect(listResult.dataOrNull, isEmpty);
  });
}
