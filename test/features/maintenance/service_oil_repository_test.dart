import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/maintenance_template_seeds.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/add_service.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/record_oil_change.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_oil_repository.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_service_repository.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/validation/oil_validator.dart';
import 'package:garir_khata/features/maintenance/domain/validation/service_validator.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  late AppDatabase db;
  late DriftServiceRepository services;
  late DriftOilRepository oils;
  late DriftExpenseRepository expenses;
  late ServiceExpenseLink link;
  late String vehicleId;
  late Vehicle vehicle;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    services = DriftServiceRepository(db);
    oils = DriftOilRepository(db);
    expenses = DriftExpenseRepository(db);
    link = ServiceExpenseLink(
      expenseRepository: expenses,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );

    final created = await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Service Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 18000,
      ),
    );
    vehicle = created.dataOrNull!;
    vehicleId = vehicle.id;
  });

  tearDown(() async {
    await db.close();
  });

  test('seeds motorcycle and car maintenance templates', () async {
    final templates = await services.getTemplates();
    expect(templates.isSuccess, isTrue);
    expect(templates.dataOrNull!.length, MaintenanceTemplateSeeds.all.length);
    expect(
      templates.dataOrNull!
          .any((t) => t.code == MaintenanceTemplateCodes.engineOil),
      isTrue,
    );
  });

  test('service create stores items and linked expense', () async {
    final add = AddService(
      repository: services,
      expenseLink: link,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    final result = await add(
      ServiceInput(
        vehicleId: vehicleId,
        serviceDate: DateTime(2026, 3, 12),
        odometer: 18250,
        vendorName: 'Riders Zone',
        laborMajor: 500,
        partsMajor: 2000,
        items: const [
          ServiceItemInput(
            title: 'Engine oil',
            maintenanceType: MaintenanceTemplateCodes.engineOil,
            costMajor: 1200,
          ),
          ServiceItemInput(
            title: 'Chain lubrication',
            maintenanceType: MaintenanceTemplateCodes.chainLubrication,
            costMajor: 800,
          ),
        ],
      ),
    );
    expect(result.isSuccess, isTrue);
    expect(result.dataOrNull!.items, hasLength(2));
    expect(result.dataOrNull!.totalCostPaisa, 250000);

    final linked = await expenses.findBySource(
      sourceType: ExpenseSourceType.service,
      sourceRecordId: result.dataOrNull!.id,
    );
    expect(linked.dataOrNull?.amountPaisa, 250000);
  });

  test('oil change creates oil + service + expense + odometer', () async {
    final record = RecordOilChange(
      oilRepository: oils,
      serviceRepository: services,
      expenseLink: link,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    final result = await record(
      input: OilChangeInput(
        vehicleId: vehicleId,
        occurredOn: DateTime(2026, 3, 12),
        odometer: 18250,
        brand: 'Motul',
        productName: '7100 4T',
        viscosity: '10W-40',
        quantityLiters: 1.2,
        costMajor: 1350,
        filterChanged: true,
      ),
      vehicleType: VehicleType.motorcycle,
    );
    expect(result.isSuccess, isTrue);
    expect(result.dataOrNull!.serviceRecordId, isNotNull);
    expect(result.dataOrNull!.nextDueOdometer, 20250);

    final service = await services.getById(result.dataOrNull!.serviceRecordId!);
    expect(service.dataOrNull, isNotNull);
    expect(service.dataOrNull!.items.isNotEmpty, isTrue);

    final linked = await expenses.findBySource(
      sourceType: ExpenseSourceType.service,
      sourceRecordId: result.dataOrNull!.serviceRecordId!,
    );
    expect(linked.dataOrNull?.amountPaisa, 135000);

    final odo = await (db.select(db.odometerEntries)
          ..where((t) => t.vehicleId.equals(vehicleId)))
        .get();
    expect(odo.any((e) => e.sourceType == 'oilChange'), isTrue);

    final refreshed = await (db.select(db.vehicles)
          ..where((t) => t.id.equals(vehicleId)))
        .getSingle();
    expect(refreshed.currentOdometer, 18250);
  });
}
