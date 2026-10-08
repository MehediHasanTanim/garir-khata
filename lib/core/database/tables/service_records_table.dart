import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('ServiceRecordRow')
@TableIndex(
  name: 'idx_service_vehicle_date',
  columns: {#vehicleId, #serviceDate},
)
class ServiceRecords extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  DateTimeColumn get serviceDate => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get vendorName => text().nullable()();
  IntColumn get laborCostPaisa => integer().withDefault(const Constant(0))();
  IntColumn get partsCostPaisa => integer().withDefault(const Constant(0))();
  IntColumn get totalCostPaisa => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
  IntColumn get nextDueOdometer => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
