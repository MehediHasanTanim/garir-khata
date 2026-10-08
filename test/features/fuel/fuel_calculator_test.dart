import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_calculator.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

void main() {
  group('FuelPrecision', () {
    test('converts liters to milliliters', () {
      expect(FuelPrecision.toMilliliters(12.6), 12600);
      expect(FuelPrecision.fromMilliliters(12600), 12.6);
    });

    test('converts money to paisa', () {
      expect(MoneyPrecision.toPaisa(1638), 163800);
      expect(MoneyPrecision.fromPaisa(163800), 1638);
    });
  });

  group('FuelCalculator', () {
    test('derives price from liters and total', () {
      final calc = FuelCalculator.calculate(
        liters: 12.6,
        pricePerLiter: null,
        totalMajor: 1638,
      );
      expect(calc, isNotNull);
      expect(calc!.quantityMl, 12600);
      expect(calc.totalCostPaisa, 163800);
      expect(calc.pricePerUnitPaisa, 13000);
    });

    test('derives total from liters and price', () {
      final calc = FuelCalculator.calculate(
        liters: 10,
        pricePerLiter: 130,
        totalMajor: null,
      );
      expect(calc, isNotNull);
      expect(calc!.totalCostPaisa, 130000);
      expect(calc.pricePerUnitPaisa, 13000);
    });
  });

  group('FuelValidator', () {
    test('requires quantity and money fields', () {
      final result = FuelValidator.validate(
        FuelInput(
          vehicleId: 'v1',
          dateTime: DateTime(2026, 10, 8),
          odometer: 100,
          fuelType: FuelType.petrol,
          isFullTank: true,
        ),
      );
      expect(result.isFailure, isTrue);
    });

    test('accepts valid fuel input', () {
      final result = FuelValidator.validate(
        FuelInput(
          vehicleId: 'v1',
          dateTime: DateTime(2026, 10, 8),
          odometer: 24830,
          fuelType: FuelType.petrol,
          isFullTank: true,
          liters: 12.6,
          totalMajor: 1638,
        ),
      );
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull!.quantityMl, 12600);
    });
  });
}
