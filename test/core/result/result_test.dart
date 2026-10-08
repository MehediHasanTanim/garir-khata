import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/errors/validation_error.dart';
import 'package:garir_khata/core/result/result.dart';

void main() {
  group('Result', () {
    test('Success exposes data', () {
      const Result<int> result = Success(42);
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, 42);
      expect(result.errorOrNull, isNull);
      expect(
        result.when(success: (value) => value * 2, failure: (_) => -1),
        84,
      );
    });

    test('Failure exposes error', () {
      const Result<int> result = Failure(
        ValidationError(message: 'Invalid', field: 'odometer'),
      );
      expect(result.isFailure, isTrue);
      expect(result.dataOrNull, isNull);
      expect(result.errorOrNull, isA<ValidationError>());
      expect(
        result.when(success: (_) => 'ok', failure: (error) => error.message),
        'Invalid',
      );
    });

    test('map transforms success values', () {
      const Result<int> result = Success(2);
      expect(result.map((value) => 'x$value').dataOrNull, 'x2');
    });
  });
}
