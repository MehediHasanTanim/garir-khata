enum VehicleType { motorcycle, scooter, car, suv, cng, microbus, pickup, other }

enum FuelType { petrol, octane, diesel, cng, lpg, electric, hybrid, other }

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
  final String? ownershipType;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
}
