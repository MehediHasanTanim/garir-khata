import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class VehicleInput {
  const VehicleInput({
    required this.nickname,
    required this.vehicleType,
    required this.fuelType,
    required this.currentOdometer,
    this.brand,
    this.model,
    this.variant,
    this.modelYear,
    this.registrationNumber,
    this.purchaseDate,
    this.purchasePricePaisa,
    this.engineCapacity,
    this.engineNumber,
    this.chassisNumber,
    this.color,
    this.photoPath,
    this.ownershipType,
  });

  final String nickname;
  final VehicleType vehicleType;
  final FuelType fuelType;
  final int currentOdometer;
  final String? brand;
  final String? model;
  final String? variant;
  final int? modelYear;
  final String? registrationNumber;
  final DateTime? purchaseDate;
  final int? purchasePricePaisa;
  final String? engineCapacity;
  final String? engineNumber;
  final String? chassisNumber;
  final String? color;
  final String? photoPath;
  final OwnershipType? ownershipType;
}

abstract final class VehicleValidator {
  static Result<VehicleInput> validate(VehicleInput input) {
    final String nickname = input.nickname.trim();
    final String? model = input.model?.trim();
    if (nickname.isEmpty && (model == null || model.isEmpty)) {
      return const Failure(
        ValidationError(
          message: 'Nickname or model is required',
          field: 'nickname',
        ),
      );
    }
    if (input.currentOdometer < 0) {
      return const Failure(
        ValidationError(
          message: 'Odometer must be zero or greater',
          field: 'currentOdometer',
        ),
      );
    }
    if (input.modelYear != null) {
      final int year = input.modelYear!;
      final int currentYear = DateTime.now().year;
      if (year < 1950 || year > currentYear + 1) {
        return Failure(
          ValidationError(
            message: 'Model year must be between 1950 and ${currentYear + 1}',
            field: 'modelYear',
          ),
        );
      }
    }
    if (input.purchasePricePaisa != null && input.purchasePricePaisa! < 0) {
      return const Failure(
        ValidationError(
          message: 'Purchase price cannot be negative',
          field: 'purchasePrice',
        ),
      );
    }

    return Success(
      VehicleInput(
        nickname: nickname.isEmpty ? (model ?? '') : nickname,
        vehicleType: input.vehicleType,
        fuelType: input.fuelType,
        currentOdometer: input.currentOdometer,
        brand: _emptyToNull(input.brand),
        model: _emptyToNull(input.model),
        variant: _emptyToNull(input.variant),
        modelYear: input.modelYear,
        registrationNumber: _emptyToNull(input.registrationNumber),
        purchaseDate: input.purchaseDate,
        purchasePricePaisa: input.purchasePricePaisa,
        engineCapacity: _emptyToNull(input.engineCapacity),
        engineNumber: _emptyToNull(input.engineNumber),
        chassisNumber: _emptyToNull(input.chassisNumber),
        color: _emptyToNull(input.color),
        photoPath: _emptyToNull(input.photoPath),
        ownershipType: input.ownershipType,
      ),
    );
  }

  static String? _emptyToNull(String? value) {
    final String? trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
