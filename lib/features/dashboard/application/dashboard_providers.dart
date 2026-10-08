import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_service.dart';
import 'package:garir_khata/features/dashboard/domain/dashboard_summary.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/fuel/application/fuel_providers.dart';
import 'package:garir_khata/features/odometer/application/odometer_providers.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  return DashboardService(
    fuelRepository: ref.watch(fuelRepositoryProvider),
    expenseRepository: ref.watch(expenseRepositoryProvider),
    odometerRepository: ref.watch(odometerRepositoryProvider),
    reportRepository: ref.watch(reportRepositoryProvider),
  );
});

class DashboardMonthNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month);
  }

  void setMonth(DateTime month) {
    state = DateTime(month.year, month.month);
  }

  void previousMonth() {
    state = DateTime(state.year, state.month - 1);
  }

  void nextMonth() {
    final DateTime next = DateTime(state.year, state.month + 1);
    final DateTime now = DateTime.now();
    if (!next.isAfter(DateTime(now.year, now.month))) {
      state = next;
    }
  }
}

final dashboardMonthProvider =
    NotifierProvider<DashboardMonthNotifier, DateTime>(DashboardMonthNotifier.new);

final dashboardSummaryProvider = FutureProvider<DashboardSummary?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  // Invalidate when fuel/expense/odometer change by watching those providers.
  ref.watch(selectedVehicleFuelHistoryProvider);
  ref.watch(selectedVehicleExpenseHistoryProvider);
  ref.watch(selectedVehicleOdometerHistoryProvider);

  final DateTime month = ref.watch(dashboardMonthProvider);
  final Result<DashboardSummary> result = await ref
      .watch(dashboardServiceProvider)
      .getSummary(vehicle: vehicle, month: month);
  return result.when(
    success: (summary) => summary,
    failure: (error) => throw error,
  );
});
