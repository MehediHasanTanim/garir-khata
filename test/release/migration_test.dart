import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('migrates previous internal schema v1 → current v7', () async {
    final dir = await Directory.systemTemp.createTemp('gk_migrate_');
    addTearDown(() async {
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    });
    final file = File(p.join(dir.path, 'old.sqlite'));

    final raw = sqlite3.open(file.path);
    raw.execute('''
      CREATE TABLE settings (
        key TEXT NOT NULL PRIMARY KEY,
        value TEXT NOT NULL,
        updated_at INTEGER NOT NULL
      );
    ''');
    raw.execute('''
      CREATE TABLE vehicles (
        id TEXT NOT NULL PRIMARY KEY,
        nickname TEXT NOT NULL,
        vehicle_type TEXT NOT NULL,
        brand TEXT NULL,
        model TEXT NULL,
        variant TEXT NULL,
        model_year INTEGER NULL,
        registration_number TEXT NULL,
        fuel_type TEXT NOT NULL,
        current_odometer INTEGER NOT NULL DEFAULT 0,
        purchase_date INTEGER NULL,
        purchase_price_paisa INTEGER NULL,
        engine_capacity TEXT NULL,
        engine_number TEXT NULL,
        chassis_number TEXT NULL,
        color TEXT NULL,
        photo_path TEXT NULL,
        ownership_type TEXT NULL,
        is_archived INTEGER NOT NULL DEFAULT 0 CHECK (is_archived IN (0, 1)),
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      );
    ''');
    raw.execute('''
      CREATE TABLE odometer_entries (
        id TEXT NOT NULL PRIMARY KEY,
        vehicle_id TEXT NOT NULL REFERENCES vehicles (id),
        recorded_at INTEGER NOT NULL,
        odometer INTEGER NOT NULL,
        source_type TEXT NOT NULL,
        source_record_id TEXT NULL,
        note TEXT NULL,
        is_manual_correction INTEGER NOT NULL DEFAULT 0
          CHECK (is_manual_correction IN (0, 1)),
        created_at INTEGER NOT NULL
      );
    ''');
    final now = DateTime.utc(2025, 1, 1).millisecondsSinceEpoch;
    raw.execute(
      'INSERT INTO vehicles (id, nickname, vehicle_type, fuel_type, '
      'current_odometer, is_archived, created_at, updated_at) '
      "VALUES ('veh-old', 'Legacy Bike', 'motorcycle', 'petrol', 1000, 0, ?, ?)",
      [now, now],
    );
    raw.execute(
      'INSERT INTO odometer_entries (id, vehicle_id, recorded_at, odometer, '
      'source_type, is_manual_correction, created_at) '
      "VALUES ('odo-old', 'veh-old', ?, 1000, 'manual', 0, ?)",
      [now, now],
    );
    raw.execute('PRAGMA user_version = 1');
    raw.dispose();

    final db = AppDatabase(NativeDatabase(file));
    addTearDown(db.close);

    final version = await db.customSelect('PRAGMA user_version').getSingle();
    expect(version.read<int>('user_version'), 7);

    final tables = await db
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type='table'",
        )
        .get();
    final names = tables.map((r) => r.read<String>('name')).toSet();
    expect(names.contains('fuel_entries'), isTrue);
    expect(names.contains('expenses'), isTrue);
    expect(names.contains('attachments'), isTrue);
    expect(names.contains('backup_history'), isTrue);

    final vehicle = await (db.select(db.vehicles)
          ..where((t) => t.id.equals('veh-old')))
        .getSingle();
    expect(vehicle.nickname, 'Legacy Bike');
    expect(vehicle.currentOdometer, 1000);

    // Existing-data test: pre-migration odometer row survives upgrade.
    final odo = await (db.select(db.odometerEntries)
          ..where((t) => t.id.equals('odo-old')))
        .getSingle();
    expect(odo.odometer, 1000);
    expect(odo.vehicleId, 'veh-old');
    expect(odo.isDiscontinuity, isFalse);

    // Column added in v2 migration
    final cols = await db
        .customSelect('PRAGMA table_info(odometer_entries)')
        .get();
    expect(
      cols.any((c) => c.read<String>('name') == 'is_discontinuity'),
      isTrue,
    );
  });

  test('corrupt schema at claimed v7 fails open predictably', () async {
    final dir = await Directory.systemTemp.createTemp('gk_corrupt_');
    addTearDown(() async {
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    });
    final file = File(p.join(dir.path, 'corrupt.sqlite'));
    final raw = sqlite3.open(file.path);
    raw.execute('CREATE TABLE only_junk (id INTEGER PRIMARY KEY);');
    raw.execute('PRAGMA user_version = 7');
    raw.dispose();

    Object? openError;
    try {
      final db = AppDatabase(NativeDatabase(file));
      // Touch a real table to force schema validation / query failure.
      await db.select(db.vehicles).get();
      await db.close();
    } on Object catch (error) {
      openError = error;
    }
    expect(openError, isNotNull);
  });
}
