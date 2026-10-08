import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/odometer/domain/repositories/odometer_repository.dart';
import 'package:garir_khata/features/odometer/domain/validation/odometer_validator.dart';

class AddFuelResult {
  const AddFuelResult({
    required this.entry,
    this.duplicateWarning = false,
  });

  final FuelEntry entry;
  final bool duplicateWarning;
}

class AddFuelEntry {
  const AddFuelEntry({
    required this.fuelRepository,
    required this.odometerRepository,
    required this.expenseLink,
    required this.uuidGenerator,
    required this.clock,
  });

  final FuelRepository fuelRepository;
  final OdometerRepository odometerRepository;
  final FuelExpenseLinkService expenseLink;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<AddFuelResult>> call(
    FuelInput input, {
    bool allowLowerOdometer = false,
    bool saveDespiteDuplicate = false,
  }) async {
    final Result<ValidatedFuelInput> validated = FuelValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedFuelInput clean =
        (validated as Success<ValidatedFuelInput>).data;

    final Result<OdometerEntry?> latest =
        await odometerRepository.getLatest(clean.vehicleId);
    if (latest case Failure(:final error)) {
      return Failure(error);
    }
    final int? previous = (latest as Success<OdometerEntry?>).data?.odometer;
    final Result<OdometerValidationResult> odoCheck =
        OdometerValidator.validate(
      entered: clean.odometer,
      previous: previous,
      allowLower: allowLowerOdometer,
    );
    if (odoCheck case Failure(:final error)) {
      return Failure(error);
    }
    final OdometerValidationResult odo =
        (odoCheck as Success<OdometerValidationResult>).data;
    if (odo.status == OdometerValidationStatus.lowerThanPrevious) {
      return const Failure(
        ValidationError(
          message: 'Odometer is lower than previous reading',
          field: 'odometer',
          code: 'odometer_lower',
        ),
      );
    }

    final Result<List<FuelEntry>> similar = await fuelRepository.findSimilar(
      vehicleId: clean.vehicleId,
      odometer: clean.odometer,
      dateTime: clean.dateTime,
      totalCostPaisa: clean.totalCostPaisa,
    );
    if (similar case Failure(:final error)) {
      return Failure(error);
    }
    final bool hasDuplicate =
        (similar as Success<List<FuelEntry>>).data.isNotEmpty;
    if (hasDuplicate && !saveDespiteDuplicate) {
      return const Failure(
        ValidationError(
          message: 'A similar fuel entry already exists',
          field: 'duplicate',
          code: 'fuel_duplicate',
        ),
      );
    }

    final DateTime now = clock.now();
    final String fuelId = uuidGenerator.v4();
    final FuelEntry fuel = FuelEntry(
      id: fuelId,
      vehicleId: clean.vehicleId,
      dateTime: clean.dateTime,
      odometer: clean.odometer,
      fuelType: clean.fuelType,
      quantityMl: clean.quantityMl,
      pricePerUnitPaisa: clean.pricePerUnitPaisa,
      totalCostPaisa: clean.totalCostPaisa,
      isFullTank: clean.isFullTank,
      stationName: clean.stationName,
      locationText: clean.locationText,
      paymentMethod: clean.paymentMethod,
      note: clean.note,
      createdAt: now,
      updatedAt: now,
    );
    final OdometerEntry odometerEntry = OdometerEntry(
      id: uuidGenerator.v4(),
      vehicleId: clean.vehicleId,
      recordedAt: clean.dateTime,
      odometer: clean.odometer,
      sourceType: OdometerSourceType.fuel,
      sourceRecordId: fuelId,
      isManualCorrection: allowLowerOdometer,
      isDiscontinuity: false,
      createdAt: now,
    );

    final Result<FuelEntry> saved = await fuelRepository.createWithOdometer(
      fuel: fuel,
      odometerEntry: odometerEntry,
    );
    if (saved case Failure(:final error)) {
      return Failure(error);
    }

    await expenseLink.upsertLinkedExpense(clean, fuelId);
    return Success(
      AddFuelResult(
        entry: (saved as Success<FuelEntry>).data,
        duplicateWarning: hasDuplicate,
      ),
    );
  }
}
