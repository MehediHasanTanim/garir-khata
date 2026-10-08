import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/features/odometer/domain/validation/odometer_validator.dart';

void main() {
  group('OdometerValidator', () {
    test('accepts equal or higher reading', () {
      final result = OdometerValidator.validate(entered: 100, previous: 90);
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull!.isValid, isTrue);
    });

    test('flags lower reading', () {
      final result = OdometerValidator.validate(entered: 80, previous: 90);
      expect(result.isSuccess, isTrue);
      expect(
        result.dataOrNull!.status,
        OdometerValidationStatus.lowerThanPrevious,
      );
    });

    test('allows lower when allowLower is true', () {
      final result = OdometerValidator.validate(
        entered: 10,
        previous: 90,
        allowLower: true,
      );
      expect(result.dataOrNull!.isValid, isTrue);
    });

    test('rejects negative', () {
      final result = OdometerValidator.validate(entered: -1);
      expect(result.isFailure, isTrue);
    });
  });
}
