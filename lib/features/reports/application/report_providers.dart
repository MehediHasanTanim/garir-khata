import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reports/data/repositories/drift_report_repository.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/reports/domain/repositories/report_repository.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  return DriftReportRepository(ref.watch(appDatabaseProvider));
});

class ReportMonthNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month);
  }

  void setMonth(DateTime month) => state = DateTime(month.year, month.month);

  void previous() => state = DateTime(state.year, state.month - 1);

  void next() {
    final next = DateTime(state.year, state.month + 1);
    final now = DateTime.now();
    if (!next.isAfter(DateTime(now.year, now.month))) {
      state = next;
    }
  }
}

final reportMonthProvider =
    NotifierProvider<ReportMonthNotifier, DateTime>(ReportMonthNotifier.new);

class ReportYearNotifier extends Notifier<int> {
  @override
  int build() => DateTime.now().year;

  void setYear(int year) => state = year;
}

final reportYearProvider =
    NotifierProvider<ReportYearNotifier, int>(ReportYearNotifier.new);

class CostPerKmModeNotifier extends Notifier<CostPerKmMode> {
  @override
  CostPerKmMode build() => CostPerKmMode.operating;

  void setMode(CostPerKmMode mode) => state = mode;
}

final costPerKmModeProvider =
    NotifierProvider<CostPerKmModeNotifier, CostPerKmMode>(
  CostPerKmModeNotifier.new,
);

class CostPerKmCategoriesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String code) {
    final next = Set<String>.of(state);
    if (next.contains(code)) {
      next.remove(code);
    } else {
      next.add(code);
    }
    state = next;
  }
}

final costPerKmCategoriesProvider =
    NotifierProvider<CostPerKmCategoriesNotifier, Set<String>>(
  CostPerKmCategoriesNotifier.new,
);

final monthlyExpenseReportProvider =
    FutureProvider<MonthlyExpenseReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final month = ref.watch(reportMonthProvider);
  final Result<MonthlyExpenseReport> result = await ref
      .watch(reportRepositoryProvider)
      .monthlyExpenses(vehicleId: vehicle.id, monthStart: month);
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});

final yearlyExpenseReportProvider =
    FutureProvider<YearlyExpenseReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final year = ref.watch(reportYearProvider);
  final Result<YearlyExpenseReport> result = await ref
      .watch(reportRepositoryProvider)
      .yearlyExpenses(vehicleId: vehicle.id, year: year);
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});

final fuelReportProvider = FutureProvider<FuelReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final year = ref.watch(reportYearProvider);
  final from = DateTime(year);
  final to = DateTime(year + 1);
  final Result<FuelReport> result = await ref
      .watch(reportRepositoryProvider)
      .fuelReport(vehicleId: vehicle.id, from: from, to: to);
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});

final mileageReportProvider = FutureProvider<MileageReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final Result<MileageReport> result =
      await ref.watch(reportRepositoryProvider).mileageReport(
            vehicleId: vehicle.id,
          );
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});

final costPerKmReportProvider = FutureProvider<CostPerKmReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final month = ref.watch(reportMonthProvider);
  final mode = ref.watch(costPerKmModeProvider);
  final codes = ref.watch(costPerKmCategoriesProvider).toList();
  final from = DateTime(month.year, month.month);
  final to = DateTime(month.year, month.month + 1);
  final Result<CostPerKmReport> result = await ref
      .watch(reportRepositoryProvider)
      .costPerKmReport(
        vehicleId: vehicle.id,
        from: from,
        to: to,
        mode: mode,
        categoryCodes: codes,
      );
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});

final maintenanceReportProvider =
    FutureProvider<MaintenanceReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final year = ref.watch(reportYearProvider);
  final from = DateTime(year);
  final to = DateTime(year + 1);
  final Result<MaintenanceReport> result = await ref
      .watch(reportRepositoryProvider)
      .maintenanceReport(vehicleId: vehicle.id, from: from, to: to);
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});

final repairReportProvider = FutureProvider<RepairReport?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final year = ref.watch(reportYearProvider);
  final from = DateTime(year);
  final to = DateTime(year + 1);
  final Result<RepairReport> result = await ref
      .watch(reportRepositoryProvider)
      .repairReport(vehicleId: vehicle.id, from: from, to: to);
  return result.when(
    success: (r) => r,
    failure: (e) => throw e,
  );
});
