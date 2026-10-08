import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/formatting/precision.dart';

void main() {
  group('MoneyPrecision', () {
    test('converts major units to paisa with banker’s rounding via round()', () {
      expect(MoneyPrecision.toPaisa(10), 1000);
      expect(MoneyPrecision.toPaisa(10.5), 1050);
      expect(MoneyPrecision.toPaisa(10.006), 1001);
      expect(MoneyPrecision.toPaisa(0.01), 1);
    });

    test('fromPaisa restores major units', () {
      expect(MoneyPrecision.fromPaisa(163800), 1638);
      expect(MoneyPrecision.fromPaisa(1), 0.01);
    });

    test('toPaisaOrNull handles null', () {
      expect(MoneyPrecision.toPaisaOrNull(null), isNull);
      expect(MoneyPrecision.toPaisaOrNull(2.5), 250);
    });
  });

  group('FuelPrecision', () {
    test('liters ↔ milliliters', () {
      expect(FuelPrecision.toMilliliters(12.6), 12600);
      expect(FuelPrecision.fromMilliliters(12600), closeTo(12.6, 1e-9));
      expect(FuelPrecision.toMilliliters(0.001), 1);
    });
  });
}
