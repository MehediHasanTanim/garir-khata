import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

class UpdateFuelEntry {
  const UpdateFuelEntry({
    required this.fuelRepository,
    required this.expenseLink,
    required this.uuidGenerator,
    required this.clock,
  });

  final FuelRepository fuelRepository;
  final FuelExpenseLinkService expenseLink;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<FuelEntry>> call({
    required String id,
    required FuelInput input,
  }) async {
    final Result<FuelEntry?> existing = await fuelRepository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    if ((existing as Success<FuelEntry?>).data == null) {
      return const Failure(
        ValidationError(message: 'Fuel entry not found', field: 'id'),
      );
    }

    final Result<ValidatedFuelInput> validated = FuelValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedFuelInput clean =
        (validated as Success<ValidatedFuelInput>).data;
    final DateTime now = clock.now();
    final FuelEntry previous = existing.data!;
    final FuelEntry fuel = FuelEntry(
      id: id,
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
      createdAt: previous.createdAt,
      updatedAt: now,
    );
    final OdometerEntry odometerEntry = OdometerEntry(
      id: uuidGenerator.v4(),
      vehicleId: clean.vehicleId,
      recordedAt: clean.dateTime,
      odometer: clean.odometer,
      sourceType: OdometerSourceType.fuel,
      sourceRecordId: id,
      isManualCorrection: false,
      isDiscontinuity: false,
      createdAt: now,
    );

    final Result<FuelEntry> saved = await fuelRepository.updateWithOdometer(
      fuel: fuel,
      odometerEntry: odometerEntry,
    );
    if (saved case Success()) {
      await expenseLink.upsertLinkedExpense(clean, id);
    }
    return saved;
  }
}
