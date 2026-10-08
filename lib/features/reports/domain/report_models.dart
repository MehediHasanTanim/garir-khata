import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';

class CategoryAmount {
  const CategoryAmount({
    required this.code,
    required this.nameEn,
    required this.amountPaisa,
    this.count = 0,
  });

  final String code;
  final String nameEn;
  final int amountPaisa;
  final int count;
}

class MonthlyExpenseReport {
  const MonthlyExpenseReport({
    required this.monthStart,
    required this.fuelPaisa,
    required this.maintenancePaisa,
    required this.repairPaisa,
    required this.documentsPaisa,
    required this.otherPaisa,
  });

  final DateTime monthStart;
  final int fuelPaisa;
  final int maintenancePaisa;
  final int repairPaisa;
  final int documentsPaisa;
  final int otherPaisa;

  int get totalPaisa =>
      fuelPaisa + maintenancePaisa + repairPaisa + documentsPaisa + otherPaisa;

  bool get isEmpty => totalPaisa == 0;
}

class YearlyExpenseReport {
  const YearlyExpenseReport({
    required this.year,
    required this.annualTotalPaisa,
    required this.monthlyAveragePaisa,
    required this.highestMonth,
    required this.highestMonthPaisa,
    required this.monthlyTotalsPaisa,
    required this.categoryBreakdown,
  });

  final int year;
  final int annualTotalPaisa;
  final double monthlyAveragePaisa;
  final int highestMonth;
  final int highestMonthPaisa;
  final List<int> monthlyTotalsPaisa; // index 0 = Jan
  final List<CategoryAmount> categoryBreakdown;

  bool get isEmpty => annualTotalPaisa == 0;
}

class MonthlyPoint {
  const MonthlyPoint({required this.monthStart, required this.value});

  final DateTime monthStart;
  final double value;
}

class FuelReport {
  const FuelReport({
    required this.from,
    required this.to,
    required this.totalLiters,
    required this.totalSpendPaisa,
    required this.averagePricePerLiterPaisa,
    required this.distanceKm,
    required this.averageMileageKmPerLiter,
    required this.fuelCostPerKm,
    required this.monthlyFuelCostPaisa,
    required this.priceTrendPaisaPerLiter,
  });

  final DateTime from;
  final DateTime to;
  final double totalLiters;
  final int totalSpendPaisa;
  final double? averagePricePerLiterPaisa;
  final int distanceKm;
  final double? averageMileageKmPerLiter;
  final CostPerKmResult fuelCostPerKm;
  final List<MonthlyPoint> monthlyFuelCostPaisa;
  final List<MonthlyPoint> priceTrendPaisaPerLiter;

  bool get isEmpty => totalSpendPaisa == 0 && totalLiters == 0;
}

class MileageReport {
  const MileageReport({
    required this.latest,
    required this.last30Days,
    required this.last90Days,
    required this.lifetime,
    required this.bestKmPerLiter,
    required this.lowestKmPerLiter,
    required this.intervals,
  });

  final MileageInterval? latest;
  final MileageAggregate last30Days;
  final MileageAggregate last90Days;
  final MileageAggregate lifetime;
  final double? bestKmPerLiter;
  final double? lowestKmPerLiter;
  final List<MileageInterval> intervals;

  bool get isEmpty => lifetime.intervals.isEmpty;
}

enum CostPerKmMode { fuelOnly, operating, custom }

class CostPerKmReport {
  const CostPerKmReport({
    required this.mode,
    required this.result,
    required this.formulaExplanation,
    required this.selectedCategoryCodes,
  });

  final CostPerKmMode mode;
  final CostPerKmResult result;
  final String formulaExplanation;
  final List<String> selectedCategoryCodes;
}

class MaintenanceReport {
  const MaintenanceReport({
    required this.totalServiceCostPaisa,
    required this.serviceCount,
    required this.averageServiceCostPaisa,
    required this.commonCategories,
  });

  final int totalServiceCostPaisa;
  final int serviceCount;
  final double averageServiceCostPaisa;
  final List<CategoryAmount> commonCategories;

  bool get isEmpty => serviceCount == 0;
}

class RepairReport {
  const RepairReport({
    required this.totalRepairCostPaisa,
    required this.repairCount,
    required this.topCategories,
    required this.repeatedCategories,
    required this.repeatThreshold,
  });

  final int totalRepairCostPaisa;
  final int repairCount;
  final List<CategoryAmount> topCategories;
  final List<CategoryAmount> repeatedCategories;
  final int repeatThreshold;

  bool get isEmpty => repairCount == 0;
}
