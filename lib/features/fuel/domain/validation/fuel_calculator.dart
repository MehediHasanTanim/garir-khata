import 'package:garir_khata/core/formatting/precision.dart';

class FuelCalculation {
  const FuelCalculation({
    required this.quantityMl,
    required this.totalCostPaisa,
    this.pricePerUnitPaisa,
  });

  final int quantityMl;
  final int totalCostPaisa;
  final int? pricePerUnitPaisa;
}

/// Derives missing price/total from liters + the other money field.
abstract final class FuelCalculator {
  static FuelCalculation? calculate({
    required double? liters,
    required double? pricePerLiter,
    required double? totalMajor,
  }) {
    if (liters == null || liters <= 0) {
      return null;
    }
    final int quantityMl = FuelPrecision.toMilliliters(liters);

    if (totalMajor != null && totalMajor >= 0) {
      final int totalPaisa = MoneyPrecision.toPaisa(totalMajor);
      final int pricePaisa = (totalPaisa / liters).round();
      return FuelCalculation(
        quantityMl: quantityMl,
        totalCostPaisa: totalPaisa,
        pricePerUnitPaisa: pricePaisa,
      );
    }

    if (pricePerLiter != null && pricePerLiter >= 0) {
      final int pricePaisa = MoneyPrecision.toPaisa(pricePerLiter);
      final int totalPaisa = MoneyPrecision.toPaisa(liters * pricePerLiter);
      return FuelCalculation(
        quantityMl: quantityMl,
        totalCostPaisa: totalPaisa,
        pricePerUnitPaisa: pricePaisa,
      );
    }

    return null;
  }
}
