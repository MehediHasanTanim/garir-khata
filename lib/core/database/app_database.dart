import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:garir_khata/core/database/tables/odometer_entries_table.dart';
import 'package:garir_khata/core/database/tables/settings_table.dart';
import 'package:garir_khata/core/database/tables/vehicles_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Settings, Vehicles, OdometerEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Schema migrations will be added in later sprints.
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'garir_khata');
  }
}
