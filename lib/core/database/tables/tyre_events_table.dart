import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/tyres_table.dart';
import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('TyreEventRow')
@TableIndex(name: 'idx_tyre_events_tyre', columns: {#tyreId, #occurredOn})
class TyreEvents extends Table {
  TextColumn get id => text()();
  TextColumn get tyreId =>
      text().references(Tyres, #id, onDelete: KeyAction.cascade)();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  /// installed | rotated | inspected | repaired | replaced | removed
  TextColumn get eventType => text()();
  DateTimeColumn get occurredOn => dateTime()();
  IntColumn get odometer => integer().nullable()();
  TextColumn get fromPosition => text().nullable()();
  TextColumn get toPosition => text().nullable()();
  TextColumn get inspectionResult => text().nullable()();
  IntColumn get costPaisa => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
