import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';

abstract interface class ReportRepository {
  Future<Result<MonthlyExpenseReport>> monthlyExpenses({
    required String vehicleId,
    required DateTime monthStart,
  });

  Future<Result<YearlyExpenseReport>> yearlyExpenses({
    required String vehicleId,
    required int year,
  });

  Future<Result<FuelReport>> fuelReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });

  Future<Result<MileageReport>> mileageReport({
    required String vehicleId,
    DateTime? now,
  });

  Future<Result<CostPerKmReport>> costPerKmReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
    required CostPerKmMode mode,
    List<String> categoryCodes = const [],
  });

  Future<Result<MaintenanceReport>> maintenanceReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });

  Future<Result<RepairReport>> repairReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
    int repeatThreshold = 2,
  });

  Future<Result<int>> documentFeesPaisa({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });

  Future<Result<int>> distanceKm({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });
}
