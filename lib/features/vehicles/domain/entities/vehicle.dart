enum VehicleType { motorcycle, scooter, car, suv, cng, microbus, pickup, other }

enum FuelType { petrol, octane, diesel, cng, lpg, electric, hybrid, other }

enum OwnershipType { personal, family, company, other }

/// Domain vehicle entity. Independent of Drift row types.
class Vehicle {
  const Vehicle({
    required this.id,
    required this.nickname,
    required this.vehicleType,
    required this.fuelType,
    required this.currentOdometer,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
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

  final String id;
  final String nickname;
  final VehicleType vehicleType;
  final String? brand;
  final String? model;
  final String? variant;
  final int? modelYear;
  final String? registrationNumber;
  final FuelType fuelType;
  final int currentOdometer;
  final DateTime? purchaseDate;
  final int? purchasePricePaisa;
  final String? engineCapacity;
  final String? engineNumber;
  final String? chassisNumber;
  final String? color;
  final String? photoPath;
  final OwnershipType? ownershipType;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get displaySubtitle {
    final parts = <String>[
      if (brand != null && brand!.trim().isNotEmpty) brand!.trim(),
      if (model != null && model!.trim().isNotEmpty) model!.trim(),
    ];
    return parts.join(' ');
  }

  Vehicle copyWith({
    String? id,
    String? nickname,
    VehicleType? vehicleType,
    String? brand,
    String? model,
    String? variant,
    int? modelYear,
    String? registrationNumber,
    FuelType? fuelType,
    int? currentOdometer,
    DateTime? purchaseDate,
    int? purchasePricePaisa,
    String? engineCapacity,
    String? engineNumber,
    String? chassisNumber,
    String? color,
    String? photoPath,
    OwnershipType? ownershipType,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearOwnershipType = false,
  }) {
    return Vehicle(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      vehicleType: vehicleType ?? this.vehicleType,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      variant: variant ?? this.variant,
      modelYear: modelYear ?? this.modelYear,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      fuelType: fuelType ?? this.fuelType,
      currentOdometer: currentOdometer ?? this.currentOdometer,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePricePaisa: purchasePricePaisa ?? this.purchasePricePaisa,
      engineCapacity: engineCapacity ?? this.engineCapacity,
      engineNumber: engineNumber ?? this.engineNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      color: color ?? this.color,
      photoPath: photoPath ?? this.photoPath,
      ownershipType: clearOwnershipType
          ? null
          : (ownershipType ?? this.ownershipType),
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
