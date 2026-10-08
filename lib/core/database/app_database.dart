import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/database/tables/expense_categories_table.dart';
import 'package:garir_khata/core/database/tables/expenses_table.dart';
import 'package:garir_khata/core/database/tables/fuel_entries_table.dart';
import 'package:garir_khata/core/database/tables/odometer_entries_table.dart';
import 'package:garir_khata/core/database/tables/settings_table.dart';
import 'package:garir_khata/core/database/tables/vehicles_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Settings,
    Vehicles,
    OdometerEntries,
    FuelEntries,
    ExpenseCategories,
    Expenses,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await customStatement('PRAGMA foreign_keys = ON');
          await ExpenseCategorySeeds.seedIfNeeded(this);
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(fuelEntries);
            await m.addColumn(odometerEntries, odometerEntries.isDiscontinuity);
          }
          if (from < 3) {
            await m.createTable(expenseCategories);
            await m.createTable(expenses);
            await ExpenseCategorySeeds.seedIfNeeded(this);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await ExpenseCategorySeeds.seedIfNeeded(this);
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'garir_khata');
  }
}
