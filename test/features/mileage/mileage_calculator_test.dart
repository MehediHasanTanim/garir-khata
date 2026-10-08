import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/mileage/domain/mileage_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

FuelEntry _fuel({
  required String id,
  required int odometer,
  required int quantityMl,
  required bool full,
  DateTime? at,
}) {
  final DateTime now = at ?? DateTime(2026, 10, 1);
  return FuelEntry(
    id: id,
    vehicleId: 'v1',
    dateTime: now,
    odometer: odometer,
    fuelType: FuelType.petrol,
    quantityMl: quantityMl,
    totalCostPaisa: 100000,
    isFullTank: full,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  group('MileageCalculator', () {
    test('two full tanks computes mileage', () {
      final intervals = MileageCalculator.calculateIntervals([
        _fuel(id: 'a', odometer: 10000, quantityMl: 10000, full: true),
        _fuel(
          id: 'b',
          odometer: 10416,
          quantityMl: 10000,
          full: true,
          at: DateTime(2026, 10, 8),
        ),
      ]);
      expect(intervals, hasLength(1));
      expect(intervals.first.status, MileageStatus.available);
      expect(intervals.first.distanceKm, 416);
      expect(intervals.first.fuelConsumedMl, 10000);
      expect(intervals.first.mileageKmPerLiter, closeTo(41.6, 0.01));
    });

    test('full → partial → full includes partial fuel', () {
      final intervals = MileageCalculator.calculateIntervals([
        _fuel(id: 'a', odometer: 10000, quantityMl: 12000, full: true),
        _fuel(
          id: 'p',
          odometer: 10200,
          quantityMl: 5000,
          full: false,
          at: DateTime(2026, 10, 3),
        ),
        _fuel(
          id: 'b',
          odometer: 10500,
          quantityMl: 7000,
          full: true,
          at: DateTime(2026, 10, 8),
        ),
      ]);
      expect(intervals.first.distanceKm, 500);
      expect(intervals.first.fuelConsumedMl, 12000); // 5L + 7L
      expect(intervals.first.mileageKmPerLiter, closeTo(41.666, 0.01));
    });

    test('multiple partials between full tanks', () {
      final aggregate = MileageCalculator.aggregate([
        _fuel(id: 'a', odometer: 0, quantityMl: 10000, full: true),
        _fuel(id: 'p1', odometer: 100, quantityMl: 2000, full: false),
        _fuel(id: 'p2', odometer: 200, quantityMl: 3000, full: false),
        _fuel(id: 'b', odometer: 400, quantityMl: 5000, full: true),
      ]);
      expect(aggregate.status, MileageStatus.available);
      expect(aggregate.totalDistanceKm, 400);
      expect(aggregate.totalFuelMl, 10000);
      expect(aggregate.averageMileageKmPerLiter, 40);
    });

    test('insufficient data with single full tank', () {
      final aggregate = MileageCalculator.aggregate([
        _fuel(id: 'a', odometer: 1000, quantityMl: 10000, full: true),
      ]);
      expect(aggregate.status, MileageStatus.insufficientData);
    });

    test('invalid odometer when distance is zero/negative', () {
      final intervals = MileageCalculator.calculateIntervals([
        _fuel(id: 'a', odometer: 5000, quantityMl: 10000, full: true),
        _fuel(id: 'b', odometer: 5000, quantityMl: 8000, full: true),
      ]);
      expect(intervals.first.status, MileageStatus.invalidOdometer);
    });

    test('zero fuel between full tanks', () {
      final intervals = MileageCalculator.calculateIntervals([
        _fuel(id: 'a', odometer: 1000, quantityMl: 10000, full: true),
        _fuel(id: 'b', odometer: 1200, quantityMl: 0, full: true),
      ]);
      expect(intervals.first.status, MileageStatus.zeroFuel);
    });
  });
}
