import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';

void main() {
  group('CostPerKmCalculator', () {
    test('computes cost per km from expenses and distance', () {
      final result = CostPerKmCalculator.calculate(
        totalExpensePaisa: 720000, // 7200 BDT
        distanceKm: 818,
      );
      expect(result.isAvailable, isTrue);
      expect(result.costPerKmMajor, closeTo(8.80, 0.01));
    });

    test('returns not enough data for zero distance', () {
      final result = CostPerKmCalculator.calculate(
        totalExpensePaisa: 100000,
        distanceKm: 0,
      );
      expect(result.status, CostPerKmStatus.notEnoughData);
      expect(result.costPerKmPaisa, isNull);
    });
  });
}
