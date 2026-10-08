import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/odometer/domain/repositories/odometer_repository.dart';
import 'package:garir_khata/features/odometer/domain/validation/odometer_validator.dart';

class AddOdometerReading {
  const AddOdometerReading({
    required this.repository,
    required this.uuidGenerator,
    required this.clock,
  });

  final OdometerRepository repository;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<OdometerEntry>> call({
    required String vehicleId,
    required int odometer,
    OdometerSourceType sourceType = OdometerSourceType.manual,
    String? note,
    bool allowLower = false,
    bool asReset = false,
  }) async {
    final Result<OdometerEntry?> latestResult =
        await repository.getLatest(vehicleId);
    if (latestResult case Failure(:final error)) {
      return Failure(error);
    }
    final int? previous = (latestResult as Success<OdometerEntry?>).data?.odometer;

    final Result<OdometerValidationResult> validated =
        OdometerValidator.validate(
      entered: odometer,
      previous: previous,
      allowLower: allowLower || asReset,
    );
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final OdometerValidationResult check =
        (validated as Success<OdometerValidationResult>).data;
    if (check.status == OdometerValidationStatus.lowerThanPrevious) {
      return const Failure(
        ValidationError(
          message: 'Odometer is lower than previous reading',
          field: 'odometer',
          code: 'odometer_lower',
        ),
      );
    }

    final DateTime now = clock.now();
    final OdometerEntry entry = OdometerEntry(
      id: uuidGenerator.v4(),
      vehicleId: vehicleId,
      recordedAt: now,
      odometer: odometer,
      sourceType: asReset ? OdometerSourceType.reset : sourceType,
      note: note,
      isManualCorrection: allowLower || asReset,
      isDiscontinuity: asReset,
      createdAt: now,
    );
    return repository.insert(entry);
  }
}
