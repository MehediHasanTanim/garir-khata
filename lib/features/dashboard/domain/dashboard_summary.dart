import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class MonthlyExpenseBreakdown {
  const MonthlyExpenseBreakdown({
    required this.fuelPaisa,
    required this.maintenancePaisa,
    required this.repairPaisa,
    required this.otherPaisa,
  });

  final int fuelPaisa;
  final int maintenancePaisa;
  final int repairPaisa;
  final int otherPaisa;

  int get totalPaisa =>
      fuelPaisa + maintenancePaisa + repairPaisa + otherPaisa;

  bool get isEmpty => totalPaisa == 0;
}

enum RecentActivityKind { fuel, expense, odometer }

class RecentActivityItem {
  const RecentActivityItem({
    required this.kind,
    required this.id,
    required this.title,
    required this.occurredAt,
    this.subtitle,
    this.amountPaisa,
    this.routePath,
  });

  final RecentActivityKind kind;
  final String id;
  final String title;
  final String? subtitle;
  final DateTime occurredAt;
  final int? amountPaisa;
  final String? routePath;
}

class DashboardSummary {
  const DashboardSummary({
    required this.vehicle,
    required this.monthStart,
    required this.monthEnd,
    required this.currentOdometer,
    required this.monthDistanceKm,
    required this.monthFuelMl,
    required this.expenses,
    required this.mileage,
    required this.costPerKm,
    required this.recentActivity,
    required this.hasAnyData,
  });

  final Vehicle vehicle;
  final DateTime monthStart;
  final DateTime monthEnd;
  final int currentOdometer;
  final int monthDistanceKm;
  final int monthFuelMl;
  final MonthlyExpenseBreakdown expenses;
  final MileageAggregate mileage;
  final CostPerKmResult costPerKm;
  final List<RecentActivityItem> recentActivity;
  final bool hasAnyData;

  double get monthFuelLiters => monthFuelMl / 1000.0;
}

/// Lightweight helper for dashboard distance within a period.
abstract final class PeriodDistanceCalculator {
  /// Prefer max − min valid odometer readings in range, skipping discontinuities
  /// when they would make distance negative or zero.
  static int fromOdometerReadings(List<int> readings) {
    if (readings.length < 2) {
      return 0;
    }
    final List<int> sorted = List<int>.of(readings)..sort();
    final int distance = sorted.last - sorted.first;
    return distance > 0 ? distance : 0;
  }

  static int fromFuelAndOdometer({
    required List<FuelEntry> fuelInPeriod,
    required List<int> odometerInPeriod,
    required int? previousOdometer,
  }) {
    final List<int> values = <int>[
      ...odometerInPeriod,
      ...fuelInPeriod.map((e) => e.odometer),
      ?previousOdometer,
    ];
    return fromOdometerReadings(values);
  }
}
