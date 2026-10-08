import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';

abstract final class MaintenanceTemplateCodes {
  static const generalService = 'general_service';
  static const engineOil = 'engine_oil';
  static const oilFilter = 'oil_filter';
  static const airFilter = 'air_filter';
  static const sparkPlug = 'spark_plug';
  static const chainLubrication = 'chain_lubrication';
  static const chainAdjustment = 'chain_adjustment';
  static const chainSprocket = 'chain_sprocket';
  static const brakeInspection = 'brake_inspection';
  static const brakePad = 'brake_pad';
  static const clutchAdjustment = 'clutch_adjustment';
  static const coolant = 'coolant';
  static const frontTyre = 'front_tyre';
  static const rearTyre = 'rear_tyre';
  static const battery = 'battery';
  static const suspension = 'suspension';
  static const transmissionOil = 'transmission_oil';
  static const acService = 'ac_service';
  static const brakeService = 'brake_service';
}

class MaintenanceTemplateSeed {
  const MaintenanceTemplateSeed({
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.vehicleType,
    required this.sortOrder,
    this.defaultKmInterval,
    this.defaultDayInterval,
    this.iconKey = 'service',
  });

  final String code;
  final String nameEn;
  final String nameBn;
  final String vehicleType;
  final int? defaultKmInterval;
  final int? defaultDayInterval;
  final String iconKey;
  final int sortOrder;
}

abstract final class MaintenanceTemplateSeeds {
  static const List<MaintenanceTemplateSeed> all = [
    // Motorcycle
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.generalService,
      nameEn: 'General service',
      nameBn: 'জেনারেল সার্ভিস',
      vehicleType: 'motorcycle',
      defaultKmInterval: 3000,
      defaultDayInterval: 180,
      iconKey: 'general_service',
      sortOrder: 10,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.engineOil,
      nameEn: 'Engine oil',
      nameBn: 'ইঞ্জিন অয়েল',
      vehicleType: 'motorcycle',
      defaultKmInterval: 2000,
      defaultDayInterval: 90,
      iconKey: 'engine_oil',
      sortOrder: 20,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.oilFilter,
      nameEn: 'Oil filter',
      nameBn: 'অয়েল ফিল্টার',
      vehicleType: 'motorcycle',
      defaultKmInterval: 4000,
      defaultDayInterval: 180,
      iconKey: 'oil_filter',
      sortOrder: 30,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.airFilter,
      nameEn: 'Air filter',
      nameBn: 'এয়ার ফিল্টার',
      vehicleType: 'motorcycle',
      defaultKmInterval: 5000,
      defaultDayInterval: 180,
      iconKey: 'air_filter',
      sortOrder: 40,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.sparkPlug,
      nameEn: 'Spark plug',
      nameBn: 'স্পার্ক প্লাগ',
      vehicleType: 'motorcycle',
      defaultKmInterval: 8000,
      defaultDayInterval: 365,
      iconKey: 'spark_plug',
      sortOrder: 50,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.chainLubrication,
      nameEn: 'Chain lubrication',
      nameBn: 'চেইন লুব্রিকেশন',
      vehicleType: 'motorcycle',
      defaultKmInterval: 500,
      defaultDayInterval: 30,
      iconKey: 'chain',
      sortOrder: 60,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.chainAdjustment,
      nameEn: 'Chain adjustment',
      nameBn: 'চেইন অ্যাডজাস্টমেন্ট',
      vehicleType: 'motorcycle',
      defaultKmInterval: 1000,
      defaultDayInterval: 60,
      iconKey: 'chain',
      sortOrder: 70,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.chainSprocket,
      nameEn: 'Chain/sprocket',
      nameBn: 'চেইন/স্প্রকেট',
      vehicleType: 'motorcycle',
      defaultKmInterval: 15000,
      defaultDayInterval: 730,
      iconKey: 'chain',
      sortOrder: 80,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.brakeInspection,
      nameEn: 'Brake inspection',
      nameBn: 'ব্রেক ইন্সপেকশন',
      vehicleType: 'motorcycle',
      defaultKmInterval: 3000,
      defaultDayInterval: 90,
      iconKey: 'brake',
      sortOrder: 90,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.brakePad,
      nameEn: 'Brake pad',
      nameBn: 'ব্রেক প্যাড',
      vehicleType: 'motorcycle',
      defaultKmInterval: 10000,
      defaultDayInterval: 365,
      iconKey: 'brake',
      sortOrder: 100,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.clutchAdjustment,
      nameEn: 'Clutch adjustment',
      nameBn: 'ক্লাচ অ্যাডজাস্টমেন্ট',
      vehicleType: 'motorcycle',
      defaultKmInterval: 5000,
      defaultDayInterval: 180,
      iconKey: 'clutch',
      sortOrder: 110,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.coolant,
      nameEn: 'Coolant',
      nameBn: 'কুল্যান্ট',
      vehicleType: 'motorcycle',
      defaultKmInterval: 10000,
      defaultDayInterval: 365,
      iconKey: 'coolant',
      sortOrder: 120,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.frontTyre,
      nameEn: 'Front tyre',
      nameBn: 'সামনের টায়ার',
      vehicleType: 'motorcycle',
      defaultKmInterval: 15000,
      defaultDayInterval: 730,
      iconKey: 'tyre',
      sortOrder: 130,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.rearTyre,
      nameEn: 'Rear tyre',
      nameBn: 'পিছনের টায়ার',
      vehicleType: 'motorcycle',
      defaultKmInterval: 12000,
      defaultDayInterval: 730,
      iconKey: 'tyre',
      sortOrder: 140,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.battery,
      nameEn: 'Battery',
      nameBn: 'ব্যাটারি',
      vehicleType: 'motorcycle',
      defaultKmInterval: null,
      defaultDayInterval: 730,
      iconKey: 'battery',
      sortOrder: 150,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.suspension,
      nameEn: 'Suspension',
      nameBn: 'সাসপেনশন',
      vehicleType: 'motorcycle',
      defaultKmInterval: 10000,
      defaultDayInterval: 365,
      iconKey: 'suspension',
      sortOrder: 160,
    ),
    // Car
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.generalService,
      nameEn: 'General service',
      nameBn: 'জেনারেল সার্ভিস',
      vehicleType: 'car',
      defaultKmInterval: 5000,
      defaultDayInterval: 180,
      iconKey: 'general_service',
      sortOrder: 10,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.engineOil,
      nameEn: 'Engine oil',
      nameBn: 'ইঞ্জিন অয়েল',
      vehicleType: 'car',
      defaultKmInterval: 5000,
      defaultDayInterval: 180,
      iconKey: 'engine_oil',
      sortOrder: 20,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.oilFilter,
      nameEn: 'Oil filter',
      nameBn: 'অয়েল ফিল্টার',
      vehicleType: 'car',
      defaultKmInterval: 5000,
      defaultDayInterval: 180,
      iconKey: 'oil_filter',
      sortOrder: 30,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.airFilter,
      nameEn: 'Air filter',
      nameBn: 'এয়ার ফিল্টার',
      vehicleType: 'car',
      defaultKmInterval: 10000,
      defaultDayInterval: 365,
      iconKey: 'air_filter',
      sortOrder: 40,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.brakeService,
      nameEn: 'Brake service',
      nameBn: 'ব্রেক সার্ভিস',
      vehicleType: 'car',
      defaultKmInterval: 10000,
      defaultDayInterval: 365,
      iconKey: 'brake',
      sortOrder: 50,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.transmissionOil,
      nameEn: 'Transmission oil',
      nameBn: 'গিয়ার অয়েল',
      vehicleType: 'car',
      defaultKmInterval: 40000,
      defaultDayInterval: 730,
      iconKey: 'engine_oil',
      sortOrder: 60,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.acService,
      nameEn: 'AC service',
      nameBn: 'এসি সার্ভিস',
      vehicleType: 'car',
      defaultKmInterval: 10000,
      defaultDayInterval: 365,
      iconKey: 'ac',
      sortOrder: 70,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.battery,
      nameEn: 'Battery',
      nameBn: 'ব্যাটারি',
      vehicleType: 'car',
      defaultKmInterval: null,
      defaultDayInterval: 1095,
      iconKey: 'battery',
      sortOrder: 80,
    ),
    MaintenanceTemplateSeed(
      code: MaintenanceTemplateCodes.sparkPlug,
      nameEn: 'Spark plug',
      nameBn: 'স্পার্ক প্লাগ',
      vehicleType: 'car',
      defaultKmInterval: 30000,
      defaultDayInterval: 730,
      iconKey: 'spark_plug',
      sortOrder: 90,
    ),
  ];

  static Future<void> seedIfNeeded(AppDatabase db) async {
    final existing = await db.select(db.maintenanceTemplates).get();
    if (existing.isNotEmpty) {
      return;
    }
    final DateTime now = DateTime.now().toUtc();
    await db.batch((batch) {
      batch.insertAll(
        db.maintenanceTemplates,
        all
            .map(
              (s) => MaintenanceTemplatesCompanion.insert(
                id: 'tmpl_${s.vehicleType}_${s.code}',
                code: s.code,
                nameEn: s.nameEn,
                nameBn: s.nameBn,
                vehicleType: Value(s.vehicleType),
                defaultKmInterval: Value(s.defaultKmInterval),
                defaultDayInterval: Value(s.defaultDayInterval),
                iconKey: Value(s.iconKey),
                isSystem: const Value(true),
                isActive: const Value(true),
                sortOrder: Value(s.sortOrder),
                createdAt: now,
              ),
            )
            .toList(),
      );
    });
  }
}
