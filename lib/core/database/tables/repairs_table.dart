import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('RepairRow')
@TableIndex(name: 'idx_repair_vehicle_date', columns: {#vehicleId, #repairDate})
class Repairs extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  DateTimeColumn get repairDate => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get category => text()();
  TextColumn get problemDescription => text()();
  TextColumn get diagnosis => text().nullable()();
  TextColumn get workPerformed => text().nullable()();
  TextColumn get vendorName => text().nullable()();
  IntColumn get laborCostPaisa => integer().withDefault(const Constant(0))();
  IntColumn get partsCostPaisa => integer().withDefault(const Constant(0))();
  IntColumn get totalCostPaisa => integer().withDefault(const Constant(0))();
  DateTimeColumn get warrantyEndDate => dateTime().nullable()();
  DateTimeColumn get followUpDate => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
