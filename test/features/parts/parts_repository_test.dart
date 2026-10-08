import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/parts/application/use_cases/add_repair.dart';
import 'package:garir_khata/features/parts/data/repair_expense_link.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_battery_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_repair_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_tyre_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_vehicle_part_repository.dart';
import 'package:garir_khata/features/parts/domain/entities/battery.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/domain/validation/repair_validator.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftRepairRepository repairs;
  late DriftVehiclePartRepository parts;
  late DriftTyreRepository tyres;
  late DriftBatteryRepository batteries;
  late DriftExpenseRepository expenses;
  late RepairExpenseLink link;
  late String vehicleId;
  const uuid = DefaultUuidGenerator();
  const clock = SystemClock();

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repairs = DriftRepairRepository(db);
    parts = DriftVehiclePartRepository(db);
    tyres = DriftTyreRepository(db);
    batteries = DriftBatteryRepository(db);
    expenses = DriftExpenseRepository(db);
    link = RepairExpenseLink(
      expenseRepository: expenses,
      uuidGenerator: uuid,
      clock: clock,
    );

    final created = await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: uuid,
      clock: clock,
    )(
      const VehicleInput(
        nickname: 'Parts Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 20000,
      ),
    );
    vehicleId = created.dataOrNull!.id;
  });

  tearDown(() async {
    await db.close();
  });

  test('repair with parts links expense for dashboard', () async {
    final add = AddRepair(
      repository: repairs,
      expenseLink: link,
      uuidGenerator: uuid,
      clock: clock,
    );
    final result = await add(
      RepairInput(
        vehicleId: vehicleId,
        repairDate: DateTime(2026, 4, 1),
        odometer: 20500,
        category: 'brake',
        problemDescription: 'Brake pads worn',
        laborMajor: 300,
        parts: const [
          RepairPartInput(
            partName: 'Brake pad',
            quantity: 2,
            unitCostMajor: 450,
          ),
        ],
      ),
    );
    expect(result.isSuccess, isTrue);
    expect(result.dataOrNull!.parts, hasLength(1));
    expect(result.dataOrNull!.partsCostPaisa, 90000);
    expect(result.dataOrNull!.totalCostPaisa, 120000);

    final linked = await expenses.findBySource(
      sourceType: ExpenseSourceType.repair,
      sourceRecordId: result.dataOrNull!.id,
    );
    expect(linked.dataOrNull?.amountPaisa, 120000);
    expect(linked.dataOrNull?.sourceType, ExpenseSourceType.repair);
  });

  test('vehicle part stores replacement interval', () async {
    final now = DateTime(2026, 5, 1);
    final result = await parts.create(
      VehiclePart(
        id: uuid.v4(),
        vehicleId: vehicleId,
        category: 'other',
        name: 'Air filter',
        installedDate: now,
        installedOdometer: 20000,
        costPaisa: 50000,
        replacementIntervalKm: 10000,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
    expect(result.isSuccess, isTrue);
    expect(result.dataOrNull!.nextDueOdometer(), 30000);
  });

  test('tyre replacement preserves previous tyre and events', () async {
    final now = DateTime(2026, 6, 1);
    final oldId = uuid.v4();
    final old = Tyre(
      id: oldId,
      vehicleId: vehicleId,
      position: TyrePosition.front,
      brand: 'MRF',
      installDate: now.subtract(const Duration(days: 400)),
      installOdometer: 15000,
      costPaisa: 300000,
      status: TyreStatus.active,
      createdAt: now,
      updatedAt: now,
    );
    await tyres.create(
      old,
      installEvent: TyreEvent(
        id: uuid.v4(),
        tyreId: oldId,
        vehicleId: vehicleId,
        eventType: TyreEventType.installed,
        occurredOn: old.installDate,
        odometer: old.installOdometer,
        toPosition: TyrePosition.front,
        createdAt: now,
      ),
    );

    final newId = uuid.v4();
    final replaced = await tyres.replace(
      oldTyre: old,
      newTyre: Tyre(
        id: newId,
        vehicleId: vehicleId,
        position: TyrePosition.front,
        brand: 'Michelin',
        installDate: now,
        installOdometer: 21000,
        costPaisa: 450000,
        status: TyreStatus.active,
        createdAt: now,
        updatedAt: now,
      ),
      removeEvent: TyreEvent(
        id: uuid.v4(),
        tyreId: oldId,
        vehicleId: vehicleId,
        eventType: TyreEventType.replaced,
        occurredOn: now,
        odometer: 21000,
        createdAt: now,
      ),
      installEvent: TyreEvent(
        id: uuid.v4(),
        tyreId: newId,
        vehicleId: vehicleId,
        eventType: TyreEventType.installed,
        occurredOn: now,
        odometer: 21000,
        toPosition: TyrePosition.front,
        createdAt: now,
      ),
    );
    expect(replaced.isSuccess, isTrue);

    final history = await tyres.getHistory(vehicleId);
    expect(history.dataOrNull, hasLength(2));
    final oldLoaded = await tyres.getById(oldId);
    expect(oldLoaded.dataOrNull!.status, TyreStatus.replaced);
    expect(
      oldLoaded.dataOrNull!.events.any(
        (e) => e.eventType == TyreEventType.replaced,
      ),
      isTrue,
    );
    final active = await tyres.getActive(vehicleId);
    expect(active.dataOrNull, hasLength(1));
    expect(active.dataOrNull!.first.brand, 'Michelin');
  });

  test('battery create replace and remove', () async {
    final now = DateTime(2026, 7, 1);
    final first = await batteries.create(
      Battery(
        id: uuid.v4(),
        vehicleId: vehicleId,
        brand: 'Lucas',
        installDate: now,
        installOdometer: 20000,
        costPaisa: 550000,
        status: BatteryStatus.active,
        createdAt: now,
        updatedAt: now,
      ),
    );
    expect(first.isSuccess, isTrue);

    final secondId = uuid.v4();
    final replaced = await batteries.replace(
      oldBattery: first.dataOrNull!,
      newBattery: Battery(
        id: secondId,
        vehicleId: vehicleId,
        brand: 'Exide',
        installDate: now.add(const Duration(days: 30)),
        installOdometer: 20500,
        costPaisa: 600000,
        status: BatteryStatus.active,
        createdAt: now,
        updatedAt: now,
      ),
    );
    expect(replaced.isSuccess, isTrue);

    final active = await batteries.getActive(vehicleId);
    expect(active.dataOrNull!.brand, 'Exide');

    await batteries.markRemoved(replaced.dataOrNull!);
    final afterRemove = await batteries.getActive(vehicleId);
    expect(afterRemove.dataOrNull, isNull);

    final history = await batteries.getHistory(vehicleId);
    expect(history.dataOrNull, hasLength(2));
  });
}
