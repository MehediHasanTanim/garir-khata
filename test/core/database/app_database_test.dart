import 'package:drift/drift.dart' show QueryRow;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('database initializes with schema version 5', () async {
    expect(db.schemaVersion, 5);
    final QueryRow row = await db
        .customSelect('PRAGMA user_version')
        .getSingle();
    expect(row.read<int>('user_version'), 5);
  });

  test('settings insert and read works', () async {
    final DateTime now = DateTime.utc(2026, 10, 8);
    await db
        .into(db.settings)
        .insert(
          SettingsCompanion.insert(key: 'locale', value: 'bn', updatedAt: now),
        );

    final SettingRow setting = await (db.select(
      db.settings,
    )..where((t) => t.key.equals('locale'))).getSingle();
    expect(setting.value, 'bn');
  });

  test('vehicles and odometer entries insert with foreign keys', () async {
    final DateTime now = DateTime.utc(2026, 10, 8);
    await db
        .into(db.vehicles)
        .insert(
          VehiclesCompanion.insert(
            id: 'veh-1',
            nickname: 'My Hornet',
            vehicleType: 'motorcycle',
            fuelType: 'petrol',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await db
        .into(db.odometerEntries)
        .insert(
          OdometerEntriesCompanion.insert(
            id: 'odo-1',
            vehicleId: 'veh-1',
            recordedAt: now,
            odometer: 24860,
            sourceType: 'manual',
            createdAt: now,
          ),
        );

    final VehicleRow vehicle = await (db.select(
      db.vehicles,
    )..where((t) => t.id.equals('veh-1'))).getSingle();
    final OdometerEntryRow odometer = await (db.select(
      db.odometerEntries,
    )..where((t) => t.vehicleId.equals('veh-1'))).getSingle();

    expect(vehicle.nickname, 'My Hornet');
    expect(odometer.odometer, 24860);
  });

  test('migration baseline onCreate creates all tables', () async {
    final List<QueryRow> tables = await db
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name",
        )
        .get();
    final Set<String> names = tables
        .map((row) => row.read<String>('name'))
        .toSet();
    expect(names.contains('settings'), isTrue);
    expect(names.contains('vehicles'), isTrue);
    expect(names.contains('odometer_entries'), isTrue);
    expect(names.contains('fuel_entries'), isTrue);
    expect(names.contains('expenses'), isTrue);
    expect(names.contains('expense_categories'), isTrue);
    expect(names.contains('maintenance_templates'), isTrue);
    expect(names.contains('service_records'), isTrue);
    expect(names.contains('service_items'), isTrue);
    expect(names.contains('oil_changes'), isTrue);
    expect(names.contains('repairs'), isTrue);
    expect(names.contains('repair_parts'), isTrue);
    expect(names.contains('vehicle_parts'), isTrue);
    expect(names.contains('tyres'), isTrue);
    expect(names.contains('tyre_events'), isTrue);
    expect(names.contains('batteries'), isTrue);
  });
}
