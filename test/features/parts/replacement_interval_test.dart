import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';

void main() {
  test('null intervals are valid', () {
    expect(ReplacementIntervalValidator.isValid(), isTrue);
  });

  test('positive intervals are valid', () {
    expect(
      ReplacementIntervalValidator.isValid(kmInterval: 10000, dayInterval: 365),
      isTrue,
    );
  });

  test('zero or negative intervals are invalid', () {
    expect(
      ReplacementIntervalValidator.isValid(kmInterval: 0),
      isFalse,
    );
    expect(
      ReplacementIntervalValidator.isValid(dayInterval: -1),
      isFalse,
    );
  });
}
