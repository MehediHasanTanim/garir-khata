import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';

void main() {
  group('NextDueCalculator', () {
    test('suggests next due from km and day intervals', () {
      final suggestion = NextDueCalculator.suggest(
        performedOdometer: 18000,
        performedAt: DateTime(2026, 3, 12),
        kmInterval: 2000,
        dayInterval: 90,
      );
      expect(suggestion.nextDueOdometer, 20000);
      expect(suggestion.nextDueDate, DateTime(2026, 6, 10));
    });

    test('marks overdue when km remaining is negative', () {
      final status = NextDueCalculator.evaluate(
        currentOdometer: 20500,
        now: DateTime(2026, 5, 1),
        nextDueOdometer: 20000,
        nextDueDate: DateTime(2026, 6, 10),
      );
      expect(status.urgency, DueUrgency.overdue);
    });

    test('marks soon within thresholds', () {
      final status = NextDueCalculator.evaluate(
        currentOdometer: 19800,
        now: DateTime(2026, 6, 1),
        nextDueOdometer: 20000,
        nextDueDate: DateTime(2026, 6, 20),
      );
      expect(status.urgency, DueUrgency.soon);
    });

    test('service total sums labor and parts', () {
      expect(
        ServiceCostCalculator.totalPaisa(laborPaisa: 50000, partsPaisa: 200000),
        250000,
      );
    });

    test('average oil interval ignores non-positive gaps', () {
      expect(
        NextDueCalculator.averageOilIntervalKm([1000, 2200, 3400]),
        closeTo(1200, 0.01),
      );
      expect(NextDueCalculator.averageOilIntervalKm([1000]), isNull);
    });
  });
}
