import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';

/// Stable system category codes used across linking and dashboard buckets.
abstract final class ExpenseCategoryCodes {
  static const fuel = 'fuel';
  static const maintenance = 'maintenance';
  static const repair = 'repair';
  static const engineOil = 'engine_oil';
  static const parts = 'parts';
  static const tyres = 'tyres';
  static const battery = 'battery';
  static const taxToken = 'tax_token';
  static const fitness = 'fitness';
  static const insurance = 'insurance';
  static const registration = 'registration';
  static const parking = 'parking';
  static const toll = 'toll';
  static const cleaning = 'cleaning';
  static const accessories = 'accessories';
  static const fine = 'fine';
  static const loanInstallment = 'loan_installment';
  static const other = 'other';
}

abstract final class ExpenseDashboardGroups {
  static const fuel = 'fuel';
  static const maintenance = 'maintenance';
  static const repair = 'repair';
  static const other = 'other';
}

abstract final class ExpenseCategorySeeds {
  static const List<ExpenseCategorySeed> all = [
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.fuel,
      nameEn: 'Fuel',
      nameBn: 'জ্বালানি',
      group: ExpenseDashboardGroups.fuel,
      iconKey: 'fuel',
      sortOrder: 10,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.maintenance,
      nameEn: 'Maintenance',
      nameBn: 'রক্ষণাবেক্ষণ',
      group: ExpenseDashboardGroups.maintenance,
      iconKey: 'maintenance',
      sortOrder: 20,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.repair,
      nameEn: 'Repair',
      nameBn: 'মেরামত',
      group: ExpenseDashboardGroups.repair,
      iconKey: 'repair',
      sortOrder: 30,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.engineOil,
      nameEn: 'Engine oil',
      nameBn: 'ইঞ্জিন অয়েল',
      group: ExpenseDashboardGroups.maintenance,
      iconKey: 'engine_oil',
      sortOrder: 40,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.parts,
      nameEn: 'Parts',
      nameBn: 'পার্টস',
      group: ExpenseDashboardGroups.repair,
      iconKey: 'parts',
      sortOrder: 50,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.tyres,
      nameEn: 'Tyres',
      nameBn: 'টায়ার',
      group: ExpenseDashboardGroups.repair,
      iconKey: 'tyres',
      sortOrder: 60,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.battery,
      nameEn: 'Battery',
      nameBn: 'ব্যাটারি',
      group: ExpenseDashboardGroups.repair,
      iconKey: 'battery',
      sortOrder: 70,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.taxToken,
      nameEn: 'Tax token',
      nameBn: 'ট্যাক্স টোকেন',
      group: ExpenseDashboardGroups.other,
      iconKey: 'tax',
      sortOrder: 80,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.fitness,
      nameEn: 'Fitness',
      nameBn: 'ফিটনেস',
      group: ExpenseDashboardGroups.other,
      iconKey: 'fitness',
      sortOrder: 90,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.insurance,
      nameEn: 'Insurance',
      nameBn: 'বীমা',
      group: ExpenseDashboardGroups.other,
      iconKey: 'insurance',
      sortOrder: 100,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.registration,
      nameEn: 'Registration',
      nameBn: 'রেজিস্ট্রেশন',
      group: ExpenseDashboardGroups.other,
      iconKey: 'registration',
      sortOrder: 110,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.parking,
      nameEn: 'Parking',
      nameBn: 'পার্কিং',
      group: ExpenseDashboardGroups.other,
      iconKey: 'parking',
      sortOrder: 120,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.toll,
      nameEn: 'Toll',
      nameBn: 'টোল',
      group: ExpenseDashboardGroups.other,
      iconKey: 'toll',
      sortOrder: 130,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.cleaning,
      nameEn: 'Cleaning',
      nameBn: 'ধোয়া/ক্লিনিং',
      group: ExpenseDashboardGroups.maintenance,
      iconKey: 'cleaning',
      sortOrder: 140,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.accessories,
      nameEn: 'Accessories',
      nameBn: 'এক্সেসরিজ',
      group: ExpenseDashboardGroups.other,
      iconKey: 'accessories',
      sortOrder: 150,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.fine,
      nameEn: 'Fine',
      nameBn: 'জরিমানা',
      group: ExpenseDashboardGroups.other,
      iconKey: 'fine',
      sortOrder: 160,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.loanInstallment,
      nameEn: 'Loan/installment',
      nameBn: 'কিস্তি/লোন',
      group: ExpenseDashboardGroups.other,
      iconKey: 'loan',
      sortOrder: 170,
    ),
    ExpenseCategorySeed(
      code: ExpenseCategoryCodes.other,
      nameEn: 'Other',
      nameBn: 'অন্যান্য',
      group: ExpenseDashboardGroups.other,
      iconKey: 'other',
      sortOrder: 999,
    ),
  ];

  static Future<void> seedIfNeeded(AppDatabase db) async {
    final existing = await db.select(db.expenseCategories).get();
    if (existing.isNotEmpty) {
      return;
    }
    final DateTime now = DateTime.now().toUtc();
    await db.batch((batch) {
      batch.insertAll(
        db.expenseCategories,
        all
            .map(
              (s) => ExpenseCategoriesCompanion.insert(
                id: 'cat_${s.code}',
                code: s.code,
                nameEn: s.nameEn,
                nameBn: s.nameBn,
                dashboardGroup: s.group,
                iconKey: Value(s.iconKey),
                isSystem: const Value(true),
                sortOrder: Value(s.sortOrder),
                createdAt: now,
              ),
            )
            .toList(),
      );
    });
  }
}

class ExpenseCategorySeed {
  const ExpenseCategorySeed({
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.group,
    required this.iconKey,
    required this.sortOrder,
  });

  final String code;
  final String nameEn;
  final String nameBn;
  final String group;
  final String iconKey;
  final int sortOrder;
}
