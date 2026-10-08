import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/logging/app_logger.dart';

void main() {
  test('sanitize redacts password and pin assignments', () {
    expect(
      AppLogger.sanitize('login pin=1234 ok'),
      contains('pin=[redacted]'),
    );
    expect(
      AppLogger.sanitize('password: hunter2'),
      contains('password=[redacted]'),
    );
    expect(
      AppLogger.sanitize('odometer 24860 updated'),
      'odometer 24860 updated',
    );
  });
}
