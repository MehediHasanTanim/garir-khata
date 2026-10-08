import 'package:flutter/material.dart';

import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

IconData vehicleTypeIcon(VehicleType type) {
  return switch (type) {
    VehicleType.motorcycle => Icons.two_wheeler,
    VehicleType.scooter => Icons.electric_scooter,
    VehicleType.car => Icons.directions_car,
    VehicleType.suv => Icons.airport_shuttle,
    VehicleType.cng => Icons.local_taxi,
    VehicleType.microbus => Icons.airport_shuttle_outlined,
    VehicleType.pickup => Icons.fire_truck,
    VehicleType.other => Icons.more_horiz,
  };
}

class VehicleTypeBadge extends StatelessWidget {
  const VehicleTypeBadge({
    required this.type,
    this.selected = false,
    this.size = 40,
    super.key,
  });

  final VehicleType type;
  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: selected
            ? Border.all(color: AppColors.primary, width: 1.5)
            : null,
      ),
      child: Icon(
        vehicleTypeIcon(type),
        color: AppColors.primary,
        size: size * 0.5,
      ),
    );
  }
}
