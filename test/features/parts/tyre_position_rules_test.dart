import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

void main() {
  test('motorcycle positions are front and rear', () {
    expect(
      TyrePositionRules.forVehicleType(VehicleType.motorcycle),
      [TyrePosition.front, TyrePosition.rear],
    );
    expect(
      TyrePositionRules.isValidFor(VehicleType.motorcycle, TyrePosition.spare),
      isFalse,
    );
  });

  test('car positions include corners and spare', () {
    final positions = TyrePositionRules.forVehicleType(VehicleType.car);
    expect(positions, contains(TyrePosition.frontLeft));
    expect(positions, contains(TyrePosition.frontRight));
    expect(positions, contains(TyrePosition.rearLeft));
    expect(positions, contains(TyrePosition.rearRight));
    expect(positions, contains(TyrePosition.spare));
    expect(
      TyrePositionRules.isValidFor(VehicleType.car, TyrePosition.front),
      isFalse,
    );
  });
}
