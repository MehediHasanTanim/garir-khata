enum CostPerKmStatus { available, notEnoughData }

class CostPerKmResult {
  const CostPerKmResult({
    required this.status,
    required this.totalExpensePaisa,
    required this.distanceKm,
    this.costPerKmPaisa,
    this.explanation,
  });

  final CostPerKmStatus status;
  final int totalExpensePaisa;
  final int distanceKm;
  final double? costPerKmPaisa;
  final String? explanation;

  bool get isAvailable => status == CostPerKmStatus.available;

  double? get costPerKmMajor =>
      costPerKmPaisa == null ? null : costPerKmPaisa! / 100.0;

  static const CostPerKmResult notEnoughData = CostPerKmResult(
    status: CostPerKmStatus.notEnoughData,
    totalExpensePaisa: 0,
    distanceKm: 0,
    explanation: 'Not enough data',
  );
}

abstract final class CostPerKmCalculator {
  /// Operating expenses (paisa) divided by valid distance (km).
  static CostPerKmResult calculate({
    required int totalExpensePaisa,
    required int distanceKm,
  }) {
    if (distanceKm <= 0) {
      return CostPerKmResult(
        status: CostPerKmStatus.notEnoughData,
        totalExpensePaisa: totalExpensePaisa,
        distanceKm: distanceKm,
        explanation: 'Not enough data',
      );
    }

    return CostPerKmResult(
      status: CostPerKmStatus.available,
      totalExpensePaisa: totalExpensePaisa,
      distanceKm: distanceKm,
      costPerKmPaisa: totalExpensePaisa / distanceKm,
    );
  }
}
