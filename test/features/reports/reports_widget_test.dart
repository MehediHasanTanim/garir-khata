import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/app/localization/l10n/app_localizations.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/presentation/monthly_expense_report_page.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  testWidgets('empty monthly report shows empty state', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final vehicle = (await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Empty',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 1000,
      ),
    )).dataOrNull!;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          selectedVehicleProvider.overrideWith((ref) async => vehicle),
          reportMonthProvider.overrideWith(() => _FixedMonth()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MonthlyExpenseReportPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('No data for this period'), findsOneWidget);
    await db.close();
  });

  testWidgets('populated monthly report shows totals and filter month', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final expenseRepo = DriftExpenseRepository(db);
    final vehicle = (await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Populated',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 1000,
      ),
    )).dataOrNull!;

    final repair = (await expenseRepo.getCategoryByCode(
      ExpenseCategoryCodes.repair,
    )).dataOrNull!;
    await AddExpense(
      repository: expenseRepo,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      ExpenseInput(
        vehicleId: vehicle.id,
        occurredOn: DateTime(2026, 10, 5),
        categoryId: repair.id,
        amountMajor: 250,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          selectedVehicleProvider.overrideWith((ref) async => vehicle),
          reportMonthProvider.overrideWith(() => _FixedMonth()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MonthlyExpenseReportPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Repairs'), findsOneWidget);
    expect(find.textContaining('250'), findsWidgets);
    expect(find.textContaining('October'), findsOneWidget);

    // Change month via next/previous — previous goes to September (empty).
    await tester.tap(find.byIcon(Icons.chevron_left));
    await tester.pumpAndSettle();
    expect(find.text('No data for this period'), findsOneWidget);

    await db.close();
  });
}

class _FixedMonth extends ReportMonthNotifier {
  @override
  DateTime build() => DateTime(2026, 10);
}
