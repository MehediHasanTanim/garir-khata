import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('BatteryRow')
@TableIndex(
  name: 'idx_batteries_vehicle_status',
  columns: {#vehicleId, #status},
)
class Batteries extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  TextColumn get brand => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get specification => text().nullable()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  DateTimeColumn get installDate => dateTime()();
  IntColumn get installOdometer => integer().nullable()();
  IntColumn get costPaisa => integer().withDefault(const Constant(0))();
  DateTimeColumn get warrantyEndDate => dateTime().nullable()();
  TextColumn get vendorName => text().nullable()();
  /// active | replaced | removed
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
