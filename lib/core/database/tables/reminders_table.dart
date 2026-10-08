import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('ReminderRow')
@TableIndex(
  name: 'idx_reminders_vehicle_status',
  columns: {#vehicleId, #status},
)
@TableIndex(name: 'idx_reminders_due_date', columns: {#vehicleId, #dueDate})
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();

  /// document | service | oil | custom | tyre | battery | other
  TextColumn get relatedEntityType => text().nullable()();
  TextColumn get relatedEntityId => text().nullable()();

  /// date | odometer | combined
  TextColumn get reminderType => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  IntColumn get dueOdometer => integer().nullable()();
  IntColumn get advanceDays => integer().withDefault(const Constant(30))();
  IntColumn get advanceKm => integer().withDefault(const Constant(500))();

  /// none | daily | weekly | monthly | custom_days | custom_km
  TextColumn get recurrenceType =>
      text().withDefault(const Constant('none'))();
  IntColumn get recurrenceDays => integer().nullable()();
  IntColumn get recurrenceKm => integer().nullable()();

  /// upcoming | due_soon | due | overdue | completed | skipped
  TextColumn get status => text().withDefault(const Constant('upcoming'))();
  BoolColumn get notificationEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get snoozedUntil => dateTime().nullable()();
  DateTimeColumn get lastTriggeredAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
