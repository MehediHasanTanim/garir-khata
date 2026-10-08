import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

class UpdateVehicle {
  const UpdateVehicle({required this.repository, required this.clock});

  final VehicleRepository repository;
  final Clock clock;

  Future<Result<Vehicle>> call({
    required String id,
    required VehicleInput input,
  }) async {
    final Result<Vehicle?> existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    final Vehicle? vehicle = (existing as Success<Vehicle?>).data;
    if (vehicle == null) {
      return const Failure(
        ValidationError(message: 'Vehicle not found', field: 'id'),
      );
    }

    final Result<VehicleInput> validated = VehicleValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final VehicleInput clean = (validated as Success<VehicleInput>).data;

    final Vehicle updated = vehicle.copyWith(
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
      clearOwnershipType: clean.ownershipType == null,
      updatedAt: clock.now(),
    );
    return repository.upsert(updated);
  }
}
