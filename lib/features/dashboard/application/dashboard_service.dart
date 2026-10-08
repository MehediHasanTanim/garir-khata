import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/domain/dashboard_summary.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/odometer/domain/repositories/odometer_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class DashboardService {
  const DashboardService({
    required this.fuelRepository,
    required this.expenseRepository,
    required this.odometerRepository,
  });

  final FuelRepository fuelRepository;
  final ExpenseRepository expenseRepository;
  final OdometerRepository odometerRepository;

  Future<Result<DashboardSummary>> getSummary({
    required Vehicle vehicle,
    DateTime? month,
  }) async {
    final DateTime anchor = month ?? DateTime.now();
    final DateTime monthStart = DateTime(anchor.year, anchor.month);
    final DateTime monthEnd = DateTime(anchor.year, anchor.month + 1);

    final Result<List<FuelEntry>> fuelResult =
        await fuelRepository.getHistory(vehicle.id, limit: 500);
    if (fuelResult case Failure(:final error)) {
      return Failure(error);
    }
    final List<FuelEntry> allFuel =
        (fuelResult as Success<List<FuelEntry>>).data;

    final Result<List<Expense>> expenseResult = await expenseRepository
        .getHistory(vehicle.id, from: monthStart, to: monthEnd, limit: 500);
    if (expenseResult case Failure(:final error)) {
      return Failure(error);
    }
    final List<Expense> monthExpenses =
        (expenseResult as Success<List<Expense>>).data;

    final Result<List<OdometerEntry>> odoResult =
        await odometerRepository.getHistory(vehicle.id, limit: 500);
    if (odoResult case Failure(:final error)) {
      return Failure(error);
    }
    final List<OdometerEntry> allOdo =
        (odoResult as Success<List<OdometerEntry>>).data;

    final int fuelPaisa = await _sumGroup(
      vehicle.id,
      monthStart,
      monthEnd,
      ExpenseDashboardGroups.fuel,
    );
    final int maintenancePaisa = await _sumGroup(
      vehicle.id,
      monthStart,
      monthEnd,
      ExpenseDashboardGroups.maintenance,
    );
    final int repairPaisa = await _sumGroup(
      vehicle.id,
      monthStart,
      monthEnd,
      ExpenseDashboardGroups.repair,
    );
    final int otherPaisa = await _sumGroup(
      vehicle.id,
      monthStart,
      monthEnd,
      ExpenseDashboardGroups.other,
    );

    final MonthlyExpenseBreakdown expenses = MonthlyExpenseBreakdown(
      fuelPaisa: fuelPaisa,
      maintenancePaisa: maintenancePaisa,
      repairPaisa: repairPaisa,
      otherPaisa: otherPaisa,
    );

    final List<FuelEntry> fuelInMonth = allFuel
        .where(
          (e) =>
              !e.dateTime.isBefore(monthStart) && e.dateTime.isBefore(monthEnd),
        )
        .toList();
    final int monthFuelMl =
        fuelInMonth.fold<int>(0, (sum, e) => sum + e.quantityMl);

    final List<int> odoInMonth = allOdo
        .where(
          (e) =>
              !e.isDiscontinuity &&
              !e.recordedAt.isBefore(monthStart) &&
              e.recordedAt.isBefore(monthEnd),
        )
        .map((e) => e.odometer)
        .toList();

    final OdometerEntry? previous = allOdo
        .where((e) => e.recordedAt.isBefore(monthStart) && !e.isDiscontinuity)
        .fold<OdometerEntry?>(null, (best, e) {
      if (best == null) {
        return e;
      }
      return e.recordedAt.isAfter(best.recordedAt) ? e : best;
    });

    final int monthDistance = PeriodDistanceCalculator.fromFuelAndOdometer(
      fuelInPeriod: fuelInMonth,
      odometerInPeriod: odoInMonth,
      previousOdometer: previous?.odometer,
    );

    // Mileage is computed live from all fuel (no stale cache).
    final MileageAggregate mileage = MileageCalculator.aggregate(allFuel);

    final CostPerKmResult costPerKm = CostPerKmCalculator.calculate(
      totalExpensePaisa: expenses.totalPaisa,
      distanceKm: monthDistance,
    );

    final List<RecentActivityItem> recent = _buildRecent(
      allFuel: allFuel,
      monthExpenses: monthExpenses,
      allOdo: allOdo,
    );

    final bool hasAnyData =
        allFuel.isNotEmpty || monthExpenses.isNotEmpty || allOdo.length > 1;

    return Success(
      DashboardSummary(
        vehicle: vehicle,
        monthStart: monthStart,
        monthEnd: monthEnd,
        currentOdometer: vehicle.currentOdometer,
        monthDistanceKm: monthDistance,
        monthFuelMl: monthFuelMl,
        expenses: expenses,
        mileage: mileage,
        costPerKm: costPerKm,
        recentActivity: recent,
        hasAnyData: hasAnyData,
      ),
    );
  }

  Future<int> _sumGroup(
    String vehicleId,
    DateTime from,
    DateTime to,
    String group,
  ) async {
    final Result<int> result = await expenseRepository.sumAmountPaisa(
      vehicleId: vehicleId,
      from: from,
      to: to,
      dashboardGroup: group,
    );
    return result is Success<int> ? result.data : 0;
  }

  List<RecentActivityItem> _buildRecent({
    required List<FuelEntry> allFuel,
    required List<Expense> monthExpenses,
    required List<OdometerEntry> allOdo,
  }) {
    final List<RecentActivityItem> items = <RecentActivityItem>[];

    for (final FuelEntry fuel in allFuel.take(10)) {
      items.add(
        RecentActivityItem(
          kind: RecentActivityKind.fuel,
          id: fuel.id,
          title: 'Fuel',
          subtitle:
              '${fuel.quantityLiters.toStringAsFixed(1)} L'
              '${fuel.stationName == null ? '' : ' · ${fuel.stationName}'}',
          occurredAt: fuel.dateTime,
          amountPaisa: fuel.totalCostPaisa,
          routePath: '/fuel/${fuel.id}',
        ),
      );
    }

    for (final Expense expense in monthExpenses) {
      if (expense.sourceType == ExpenseSourceType.fuel) {
        continue;
      }
      items.add(
        RecentActivityItem(
          kind: RecentActivityKind.expense,
          id: expense.id,
          title: expense.category?.nameEn ??
              expense.description ??
              'Expense',
          subtitle: expense.vendorName,
          occurredAt: expense.occurredOn,
          amountPaisa: expense.amountPaisa,
          routePath: '/expenses/${expense.id}',
        ),
      );
    }

    for (final OdometerEntry odo in allOdo.take(5)) {
      if (odo.sourceType == OdometerSourceType.fuel) {
        continue;
      }
      items.add(
        RecentActivityItem(
          kind: RecentActivityKind.odometer,
          id: odo.id,
          title: 'Odometer',
          subtitle: '${odo.odometer} km',
          occurredAt: odo.recordedAt,
          routePath: '/odometer/history',
        ),
      );
    }

    items.sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return items.take(8).toList();
  }
}
