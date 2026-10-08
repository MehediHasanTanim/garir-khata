import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/maintenance_templates_table.dart';
import 'package:garir_khata/core/database/tables/service_records_table.dart';

@DataClassName('ServiceItemRow')
@TableIndex(name: 'idx_service_items_record', columns: {#serviceRecordId})
class ServiceItems extends Table {
  TextColumn get id => text()();
  TextColumn get serviceRecordId =>
      text().references(ServiceRecords, #id, onDelete: KeyAction.cascade)();
  TextColumn get templateId =>
      text().nullable().references(MaintenanceTemplates, #id)();
  TextColumn get maintenanceType => text()();
  TextColumn get title => text()();
  IntColumn get costPaisa => integer().withDefault(const Constant(0))();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  TextColumn get note => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
