import 'package:drift/drift.dart';

@DataClassName('MaintenanceTemplateRow')
class MaintenanceTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
  /// motorcycle | car | all
  TextColumn get vehicleType => text().withDefault(const Constant('all'))();
  IntColumn get defaultKmInterval => integer().nullable()();
  IntColumn get defaultDayInterval => integer().nullable()();
  TextColumn get iconKey => text().withDefault(const Constant('service'))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(true))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {code, vehicleType},
      ];
}
