import 'package:drift/drift.dart';

@DataClassName('ExpenseCategoryRow')
class ExpenseCategories extends Table {
  TextColumn get id => text()();
  TextColumn get code => text().unique()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
  /// Dashboard bucket: fuel | maintenance | repair | other
  TextColumn get dashboardGroup => text()();
  TextColumn get iconKey => text().withDefault(const Constant('other'))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
