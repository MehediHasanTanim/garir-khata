import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('VehiclePartRow')
@TableIndex(
  name: 'idx_vehicle_parts_vehicle',
  columns: {#vehicleId, #installedDate},
)
class VehicleParts extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  TextColumn get category => text()();
  TextColumn get name => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get partNumber => text().nullable()();
  DateTimeColumn get installedDate => dateTime()();
  IntColumn get installedOdometer => integer().nullable()();
  IntColumn get costPaisa => integer().withDefault(const Constant(0))();
  TextColumn get vendorName => text().nullable()();
  DateTimeColumn get warrantyEndDate => dateTime().nullable()();
  IntColumn get replacementIntervalKm => integer().nullable()();
  IntColumn get replacementIntervalDays => integer().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
