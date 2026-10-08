import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/database/seeds/maintenance_template_seeds.dart';
import 'package:garir_khata/core/database/tables/batteries_table.dart';
import 'package:garir_khata/core/database/tables/expense_categories_table.dart';
import 'package:garir_khata/core/database/tables/expenses_table.dart';
import 'package:garir_khata/core/database/tables/fuel_entries_table.dart';
import 'package:garir_khata/core/database/tables/maintenance_templates_table.dart';
import 'package:garir_khata/core/database/tables/odometer_entries_table.dart';
import 'package:garir_khata/core/database/tables/oil_changes_table.dart';
import 'package:garir_khata/core/database/tables/repair_parts_table.dart';
import 'package:garir_khata/core/database/tables/repairs_table.dart';
import 'package:garir_khata/core/database/tables/service_items_table.dart';
import 'package:garir_khata/core/database/tables/service_records_table.dart';
import 'package:garir_khata/core/database/tables/settings_table.dart';
import 'package:garir_khata/core/database/tables/tyre_events_table.dart';
import 'package:garir_khata/core/database/tables/tyres_table.dart';
import 'package:garir_khata/core/database/tables/vehicle_parts_table.dart';
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
    MaintenanceTemplates,
    ServiceRecords,
    ServiceItems,
    OilChanges,
    Repairs,
    RepairParts,
    VehicleParts,
    Tyres,
    TyreEvents,
    Batteries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await customStatement('PRAGMA foreign_keys = ON');
          await ExpenseCategorySeeds.seedIfNeeded(this);
          await MaintenanceTemplateSeeds.seedIfNeeded(this);
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
          if (from < 4) {
            await m.createTable(maintenanceTemplates);
            await m.createTable(serviceRecords);
            await m.createTable(serviceItems);
            await m.createTable(oilChanges);
            await MaintenanceTemplateSeeds.seedIfNeeded(this);
          }
          if (from < 5) {
            await m.createTable(repairs);
            await m.createTable(repairParts);
            await m.createTable(vehicleParts);
            await m.createTable(tyres);
            await m.createTable(tyreEvents);
            await m.createTable(batteries);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await ExpenseCategorySeeds.seedIfNeeded(this);
          await MaintenanceTemplateSeeds.seedIfNeeded(this);
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'garir_khata');
  }
}
