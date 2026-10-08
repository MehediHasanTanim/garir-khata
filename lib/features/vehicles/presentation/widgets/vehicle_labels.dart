import 'package:flutter/widgets.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

String vehicleTypeLabel(BuildContext context, VehicleType type) {
  final l10n = context.l10n;
  return switch (type) {
    VehicleType.motorcycle => l10n.vehicleTypeMotorcycle,
    VehicleType.scooter => l10n.vehicleTypeScooter,
    VehicleType.car => l10n.vehicleTypeCar,
    VehicleType.suv => l10n.vehicleTypeSuv,
    VehicleType.cng => l10n.vehicleTypeCng,
    VehicleType.microbus => l10n.vehicleTypeMicrobus,
    VehicleType.pickup => l10n.vehicleTypePickup,
    VehicleType.other => l10n.vehicleTypeOther,
  };
}

String fuelTypeLabel(BuildContext context, FuelType type) {
  final l10n = context.l10n;
  return switch (type) {
    FuelType.petrol => l10n.fuelTypePetrol,
    FuelType.octane => l10n.fuelTypeOctane,
    FuelType.diesel => l10n.fuelTypeDiesel,
    FuelType.cng => l10n.fuelTypeCng,
    FuelType.lpg => l10n.fuelTypeLpg,
    FuelType.electric => l10n.fuelTypeElectric,
    FuelType.hybrid => l10n.fuelTypeHybrid,
    FuelType.other => l10n.fuelTypeOther,
  };
}

String ownershipTypeLabel(BuildContext context, OwnershipType type) {
  final l10n = context.l10n;
  return switch (type) {
    OwnershipType.personal => l10n.ownershipPersonal,
    OwnershipType.family => l10n.ownershipFamily,
    OwnershipType.company => l10n.ownershipCompany,
    OwnershipType.other => l10n.ownershipOther,
  };
}
