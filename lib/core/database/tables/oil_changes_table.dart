import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/service_records_table.dart';
import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('OilChangeRow')
@TableIndex(
  name: 'idx_oil_vehicle_date',
  columns: {#vehicleId, #occurredOn},
)
class OilChanges extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  DateTimeColumn get occurredOn => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get brand => text().nullable()();
  TextColumn get productName => text().nullable()();
  TextColumn get viscosity => text().nullable()();
  /// Quantity in milliliters.
  IntColumn get quantityMl => integer().nullable()();
  IntColumn get costPaisa => integer().withDefault(const Constant(0))();
  BoolColumn get filterChanged =>
      boolean().withDefault(const Constant(false))();
  TextColumn get vendorName => text().nullable()();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
  IntColumn get nextDueOdometer => integer().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get serviceRecordId =>
      text().nullable().references(ServiceRecords, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
