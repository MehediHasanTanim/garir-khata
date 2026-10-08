import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/expense_categories_table.dart';
import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('ExpenseRow')
@TableIndex(name: 'idx_expense_vehicle_date', columns: {#vehicleId, #occurredOn})
@TableIndex(
  name: 'idx_expense_source',
  columns: {#sourceType, #sourceRecordId},
)
class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  /// Named occurredOn so the getter does not collide with common names.
  DateTimeColumn get occurredOn => dateTime()();
  TextColumn get categoryId =>
      text().references(ExpenseCategories, #id)();
  /// Amount stored as paisa.
  IntColumn get amountPaisa => integer()();
  IntColumn get odometer => integer().nullable()();
  TextColumn get vendorId => text().nullable()();
  TextColumn get vendorName => text().nullable()();
  TextColumn get paymentMethod => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get note => text().nullable()();
  /// manual | fuel | service | repair | import
  TextColumn get sourceType => text().withDefault(const Constant('manual'))();
  TextColumn get sourceRecordId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
