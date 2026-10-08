/// Fixed-precision helpers for money (paisa) and fuel (milliliters).
abstract final class MoneyPrecision {
  static int toPaisa(num majorUnits) => (majorUnits * 100).round();

  static double fromPaisa(int paisa) => paisa / 100.0;

  static int? toPaisaOrNull(num? majorUnits) {
    if (majorUnits == null) {
      return null;
    }
    return toPaisa(majorUnits);
  }
}

abstract final class FuelPrecision {
  static int toMilliliters(num liters) => (liters * 1000).round();

  static double fromMilliliters(int milliliters) => milliliters / 1000.0;
}
