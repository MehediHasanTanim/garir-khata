import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

abstract final class VehicleMapper {
  static Vehicle toDomain(VehicleRow row) {
    return Vehicle(
      id: row.id,
      nickname: row.nickname,
      vehicleType: VehicleType.values.byName(row.vehicleType),
      brand: row.brand,
      model: row.model,
      variant: row.variant,
      modelYear: row.modelYear,
      registrationNumber: row.registrationNumber,
      fuelType: FuelType.values.byName(row.fuelType),
      currentOdometer: row.currentOdometer,
      purchaseDate: row.purchaseDate,
      purchasePricePaisa: row.purchasePricePaisa,
      engineCapacity: row.engineCapacity,
      engineNumber: row.engineNumber,
      chassisNumber: row.chassisNumber,
      color: row.color,
      photoPath: row.photoPath,
      ownershipType: row.ownershipType,
      isArchived: row.isArchived,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static VehiclesCompanion toCompanion(Vehicle vehicle) {
    return VehiclesCompanion.insert(
      id: vehicle.id,
      nickname: vehicle.nickname,
      vehicleType: vehicle.vehicleType.name,
      brand: Value(vehicle.brand),
      model: Value(vehicle.model),
      variant: Value(vehicle.variant),
      modelYear: Value(vehicle.modelYear),
      registrationNumber: Value(vehicle.registrationNumber),
      fuelType: vehicle.fuelType.name,
      currentOdometer: Value(vehicle.currentOdometer),
      purchaseDate: Value(vehicle.purchaseDate),
      purchasePricePaisa: Value(vehicle.purchasePricePaisa),
      engineCapacity: Value(vehicle.engineCapacity),
      engineNumber: Value(vehicle.engineNumber),
      chassisNumber: Value(vehicle.chassisNumber),
      color: Value(vehicle.color),
      photoPath: Value(vehicle.photoPath),
      ownershipType: Value(vehicle.ownershipType),
      isArchived: Value(vehicle.isArchived),
      createdAt: vehicle.createdAt,
      updatedAt: vehicle.updatedAt,
    );
  }
}
