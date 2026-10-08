import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/repairs_table.dart';

@DataClassName('RepairPartRow')
@TableIndex(name: 'idx_repair_parts_repair', columns: {#repairId})
class RepairParts extends Table {
  TextColumn get id => text()();
  TextColumn get repairId =>
      text().references(Repairs, #id, onDelete: KeyAction.cascade)();
  TextColumn get partName => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get partNumber => text().nullable()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  IntColumn get unitCostPaisa => integer().withDefault(const Constant(0))();
  IntColumn get totalCostPaisa => integer().withDefault(const Constant(0))();
  DateTimeColumn get warrantyEndDate => dateTime().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
