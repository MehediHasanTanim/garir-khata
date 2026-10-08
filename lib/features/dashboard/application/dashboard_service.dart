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
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/reports/domain/repositories/report_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class DashboardService {
  const DashboardService({
    required this.fuelRepository,
    required this.expenseRepository,
    required this.odometerRepository,
    required this.reportRepository,
  });

  final FuelRepository fuelRepository;
  final ExpenseRepository expenseRepository;
  final OdometerRepository odometerRepository;
  final ReportRepository reportRepository;

  Future<Result<DashboardSummary>> getSummary({
    required Vehicle vehicle,
    DateTime? month,
  }) async {
    final DateTime anchor = month ?? DateTime.now();
    final DateTime monthStart = DateTime(anchor.year, anchor.month);
    final DateTime monthEnd = DateTime(anchor.year, anchor.month + 1);

    // Aggregations in DB — no N+1 group sums.
    final monthlyResult = await reportRepository.monthlyExpenses(
      vehicleId: vehicle.id,
      monthStart: monthStart,
    );
    if (monthlyResult case Failure(:final error)) {
      return Failure(error);
    }
    final monthly =
        (monthlyResult as Success<MonthlyExpenseReport>).data;

    final distanceResult = await reportRepository.distanceKm(
      vehicleId: vehicle.id,
      from: monthStart,
      to: monthEnd,
    );
    if (distanceResult case Failure(:final error)) {
      return Failure(error);
    }
    final int monthDistance = (distanceResult as Success<int>).data;

    final fuelReportResult = await reportRepository.fuelReport(
      vehicleId: vehicle.id,
      from: monthStart,
      to: monthEnd,
    );
    if (fuelReportResult case Failure(:final error)) {
      return Failure(error);
    }
    final fuelMonth = (fuelReportResult as Success<FuelReport>).data;
    final int monthFuelMl = (fuelMonth.totalLiters * 1000).round();

    // Limited fuel history for lifetime mileage (DB-ordered, capped).
    final Result<List<FuelEntry>> fuelResult =
        await fuelRepository.getHistory(vehicle.id, limit: 200);
    if (fuelResult case Failure(:final error)) {
      return Failure(error);
    }
    final List<FuelEntry> fuelForMileage =
        (fuelResult as Success<List<FuelEntry>>).data;
    final MileageAggregate mileage =
        MileageCalculator.aggregate(fuelForMileage);

    final MonthlyExpenseBreakdown expenses = MonthlyExpenseBreakdown(
      fuelPaisa: monthly.fuelPaisa,
      maintenancePaisa: monthly.maintenancePaisa,
      repairPaisa: monthly.repairPaisa,
      otherPaisa: monthly.documentsPaisa + monthly.otherPaisa,
    );

    final CostPerKmResult costPerKm = CostPerKmCalculator.calculate(
      totalExpensePaisa: expenses.totalPaisa,
      distanceKm: monthDistance,
    );

    // Recent activity: bounded queries only.
    final recent = await _loadRecent(vehicle.id, monthStart, monthEnd);

    final bool hasAnyData = fuelForMileage.isNotEmpty ||
        expenses.totalPaisa > 0 ||
        recent.isNotEmpty;

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

  Future<List<RecentActivityItem>> _loadRecent(
    String vehicleId,
    DateTime monthStart,
    DateTime monthEnd,
  ) async {
    final fuelResult =
        await fuelRepository.getHistory(vehicleId, limit: 10);
    final expenseResult = await expenseRepository.getHistory(
      vehicleId,
      from: monthStart,
      to: monthEnd,
      limit: 15,
    );
    final odoResult =
        await odometerRepository.getHistory(vehicleId, limit: 5);

    final List<FuelEntry> recentFuel =
        fuelResult is Success<List<FuelEntry>> ? fuelResult.data : const [];
    final List<Expense> recentExpenses =
        expenseResult is Success<List<Expense>> ? expenseResult.data : const [];
    final List<OdometerEntry> recentOdo =
        odoResult is Success<List<OdometerEntry>> ? odoResult.data : const [];

    final List<RecentActivityItem> items = <RecentActivityItem>[];

    for (final FuelEntry fuel in recentFuel) {
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

    for (final Expense expense in recentExpenses) {
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

    for (final OdometerEntry odo in recentOdo) {
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
