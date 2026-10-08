import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/app/localization/l10n/app_localizations.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/presentation/add_edit_expense_page.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

void main() {
  testWidgets('expense form shows category chips and amount field', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final now = DateTime.utc(2026, 10, 8);
    final vehicle = Vehicle(
      id: 'v1',
      nickname: 'Test Bike',
      vehicleType: VehicleType.motorcycle,
      fuelType: FuelType.petrol,
      currentOdometer: 1000,
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );
    final categories = [
      ExpenseCategory(
        id: 'cat_repair',
        code: 'repair',
        nameEn: 'Repair',
        nameBn: 'মেরামত',
        dashboardGroup: 'repair',
        iconKey: 'repair',
        isSystem: true,
        sortOrder: 1,
        isArchived: false,
        createdAt: now,
      ),
      ExpenseCategory(
        id: 'cat_other',
        code: 'other',
        nameEn: 'Other',
        nameBn: 'অন্যান্য',
        dashboardGroup: 'other',
        iconKey: 'other',
        isSystem: true,
        sortOrder: 2,
        isArchived: false,
        createdAt: now,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          selectedVehicleProvider.overrideWith((ref) async => vehicle),
          expenseCategoriesProvider.overrideWith((ref) async => categories),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AddEditExpensePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Repair'), findsOneWidget);
    expect(find.text('Other'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('Expense title'), findsOneWidget);

    await db.close();
  });
}
