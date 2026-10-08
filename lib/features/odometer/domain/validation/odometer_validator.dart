import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';

enum OdometerValidationStatus { valid, lowerThanPrevious }

class OdometerValidationResult {
  const OdometerValidationResult({
    required this.status,
    required this.entered,
    this.previous,
  });

  final OdometerValidationStatus status;
  final int entered;
  final int? previous;

  bool get isValid => status == OdometerValidationStatus.valid;
}

abstract final class OdometerValidator {
  static Result<OdometerValidationResult> validate({
    required int entered,
    int? previous,
    bool allowLower = false,
  }) {
    if (entered < 0) {
      return const Failure(
        ValidationError(
          message: 'Odometer must be zero or greater',
          field: 'odometer',
        ),
      );
    }
    if (!allowLower && previous != null && entered < previous) {
      return Success(
        OdometerValidationResult(
          status: OdometerValidationStatus.lowerThanPrevious,
          entered: entered,
          previous: previous,
        ),
      );
    }
    return Success(
      OdometerValidationResult(
        status: OdometerValidationStatus.valid,
        entered: entered,
        previous: previous,
      ),
    );
  }
}
