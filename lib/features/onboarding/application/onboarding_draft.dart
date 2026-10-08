import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class OnboardingDraft {
  const OnboardingDraft({
    this.vehicleType = VehicleType.motorcycle,
    this.nickname = '',
    this.brand = '',
    this.model = '',
    this.variant = '',
    this.modelYear,
    this.fuelType = FuelType.petrol,
    this.color = '',
    this.registrationNumber = '',
    this.engineCapacity = '',
    this.engineNumber = '',
    this.chassisNumber = '',
    this.ownershipType,
    this.purchaseDate,
    this.purchasePriceMajor,
    this.currentOdometer = 0,
  });

  final VehicleType vehicleType;
  final String nickname;
  final String brand;
  final String model;
  final String variant;
  final int? modelYear;
  final FuelType fuelType;
  final String color;
  final String registrationNumber;
  final String engineCapacity;
  final String engineNumber;
  final String chassisNumber;
  final OwnershipType? ownershipType;
  final DateTime? purchaseDate;
  final double? purchasePriceMajor;
  final int currentOdometer;

  OnboardingDraft copyWith({
    VehicleType? vehicleType,
    String? nickname,
    String? brand,
    String? model,
    String? variant,
    int? modelYear,
    FuelType? fuelType,
    String? color,
    String? registrationNumber,
    String? engineCapacity,
    String? engineNumber,
    String? chassisNumber,
    OwnershipType? ownershipType,
    DateTime? purchaseDate,
    double? purchasePriceMajor,
    int? currentOdometer,
    bool clearModelYear = false,
    bool clearOwnershipType = false,
    bool clearPurchaseDate = false,
    bool clearPurchasePrice = false,
  }) {
    return OnboardingDraft(
      vehicleType: vehicleType ?? this.vehicleType,
      nickname: nickname ?? this.nickname,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      variant: variant ?? this.variant,
      modelYear: clearModelYear ? null : (modelYear ?? this.modelYear),
      fuelType: fuelType ?? this.fuelType,
      color: color ?? this.color,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      engineCapacity: engineCapacity ?? this.engineCapacity,
      engineNumber: engineNumber ?? this.engineNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      ownershipType: clearOwnershipType
          ? null
          : (ownershipType ?? this.ownershipType),
      purchaseDate: clearPurchaseDate
          ? null
          : (purchaseDate ?? this.purchaseDate),
      purchasePriceMajor: clearPurchasePrice
          ? null
          : (purchasePriceMajor ?? this.purchasePriceMajor),
      currentOdometer: currentOdometer ?? this.currentOdometer,
    );
  }
}
