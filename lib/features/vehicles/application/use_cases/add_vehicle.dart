import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

class AddVehicle {
  const AddVehicle({
    required this.repository,
    required this.uuidGenerator,
    required this.clock,
  });

  final VehicleRepository repository;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<Vehicle>> call(VehicleInput input) async {
    final Result<VehicleInput> validated = VehicleValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final VehicleInput clean = (validated as Success<VehicleInput>).data;
    final DateTime now = clock.now();
    final Vehicle vehicle = Vehicle(
      id: uuidGenerator.v4(),
      nickname: clean.nickname,
      vehicleType: clean.vehicleType,
      brand: clean.brand,
      model: clean.model,
      variant: clean.variant,
      modelYear: clean.modelYear,
      registrationNumber: clean.registrationNumber,
      fuelType: clean.fuelType,
      currentOdometer: clean.currentOdometer,
      purchaseDate: clean.purchaseDate,
      purchasePricePaisa: clean.purchasePricePaisa,
      engineCapacity: clean.engineCapacity,
      engineNumber: clean.engineNumber,
      chassisNumber: clean.chassisNumber,
      color: clean.color,
      photoPath: clean.photoPath,
      ownershipType: clean.ownershipType,
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );
    return repository.createWithInitialOdometer(
      vehicle: vehicle,
      odometerEntryId: uuidGenerator.v4(),
    );
  }
}
