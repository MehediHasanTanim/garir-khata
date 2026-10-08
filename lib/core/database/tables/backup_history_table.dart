import 'package:drift/drift.dart';

@DataClassName('BackupHistoryRow')
class BackupHistory extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get pathOrUri => text()();
  IntColumn get sizeBytes => integer()();
  IntColumn get vehicleCount => integer().withDefault(const Constant(0))();
  IntColumn get schemaVersion => integer()();
  /// success | failed | interrupted
  TextColumn get status => text()();
  BoolColumn get includeAttachments =>
      boolean().withDefault(const Constant(true))();
  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
