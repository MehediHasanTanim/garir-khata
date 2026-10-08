import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

enum TyrePosition {
  front,
  rear,
  frontLeft,
  frontRight,
  rearLeft,
  rearRight,
  spare,
}

abstract final class TyrePositionRules {
  static List<TyrePosition> forVehicleType(VehicleType type) {
    return switch (type) {
      VehicleType.motorcycle || VehicleType.scooter => const [
          TyrePosition.front,
          TyrePosition.rear,
        ],
      VehicleType.car ||
      VehicleType.suv ||
      VehicleType.microbus ||
      VehicleType.pickup ||
      VehicleType.cng =>
        const [
          TyrePosition.frontLeft,
          TyrePosition.frontRight,
          TyrePosition.rearLeft,
          TyrePosition.rearRight,
          TyrePosition.spare,
        ],
      VehicleType.other => const [
          TyrePosition.front,
          TyrePosition.rear,
          TyrePosition.spare,
        ],
    };
  }

  static bool isValidFor(VehicleType type, TyrePosition position) {
    return forVehicleType(type).contains(position);
  }

  static String labelEn(TyrePosition position) {
    return switch (position) {
      TyrePosition.front => 'Front',
      TyrePosition.rear => 'Rear',
      TyrePosition.frontLeft => 'FL',
      TyrePosition.frontRight => 'FR',
      TyrePosition.rearLeft => 'RL',
      TyrePosition.rearRight => 'RR',
      TyrePosition.spare => 'Spare',
    };
  }

  static String labelBn(TyrePosition position) {
    return switch (position) {
      TyrePosition.front => 'সামনে',
      TyrePosition.rear => 'পিছনে',
      TyrePosition.frontLeft => 'সামনে বাম',
      TyrePosition.frontRight => 'সামনে ডান',
      TyrePosition.rearLeft => 'পিছনে বাম',
      TyrePosition.rearRight => 'পিছনে ডান',
      TyrePosition.spare => 'স্পেয়ার',
    };
  }
}

enum TyreEventType {
  installed,
  rotated,
  inspected,
  repaired,
  replaced,
  removed,
}

enum TyreStatus { active, replaced, removed, stored }

enum BatteryStatus { active, replaced, removed }
