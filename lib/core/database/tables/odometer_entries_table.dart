import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('OdometerEntryRow')
@TableIndex(
  name: 'idx_odometer_vehicle_recorded',
  columns: {#vehicleId, #recordedAt},
)
@TableIndex(
  name: 'idx_odometer_vehicle_odometer',
  columns: {#vehicleId, #odometer},
)
class OdometerEntries extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  DateTimeColumn get recordedAt => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get sourceType => text()();
  TextColumn get sourceRecordId => text().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isManualCorrection =>
      boolean().withDefault(const Constant(false))();
  /// Marks odometer reset/replacement discontinuities for reports.
  BoolColumn get isDiscontinuity =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
