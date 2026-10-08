import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('FuelEntryRow')
@TableIndex(
  name: 'idx_fuel_vehicle_datetime',
  columns: {#entryDateTime, #vehicleId},
)
@TableIndex(
  name: 'idx_fuel_vehicle_odometer',
  columns: {#vehicleId, #odometer},
)
class FuelEntries extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  /// Named entryDateTime so the getter does not shadow Table.dateTime().
  DateTimeColumn get entryDateTime => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get fuelType => text()();
  /// Quantity stored as milliliters for fixed precision.
  IntColumn get quantityMl => integer()();
  /// Unit price stored as paisa per liter.
  IntColumn get pricePerUnitPaisa => integer().nullable()();
  /// Total cost stored as paisa.
  IntColumn get totalCostPaisa => integer()();
  BoolColumn get isFullTank => boolean().withDefault(const Constant(false))();
  TextColumn get vendorId => text().nullable()();
  TextColumn get stationName => text().nullable()();
  TextColumn get locationText => text().nullable()();
  TextColumn get paymentMethod => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
