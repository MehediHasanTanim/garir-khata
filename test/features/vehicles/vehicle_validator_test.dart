import 'package:flutter_test/flutter_test.dart';

import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

void main() {
  group('VehicleValidator', () {
    test('requires nickname or model', () {
      final Result<VehicleInput> result = VehicleValidator.validate(
        const VehicleInput(
          nickname: '  ',
          vehicleType: VehicleType.motorcycle,
          fuelType: FuelType.petrol,
          currentOdometer: 0,
        ),
      );
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<ValidationError>());
    });

    test('accepts model without nickname', () {
      final Result<VehicleInput> result = VehicleValidator.validate(
        const VehicleInput(
          nickname: '',
          model: 'FZS',
          vehicleType: VehicleType.motorcycle,
          fuelType: FuelType.petrol,
          currentOdometer: 100,
        ),
      );
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull!.nickname, 'FZS');
    });

    test('rejects negative odometer', () {
      final Result<VehicleInput> result = VehicleValidator.validate(
        const VehicleInput(
          nickname: 'Bike',
          vehicleType: VehicleType.motorcycle,
          fuelType: FuelType.petrol,
          currentOdometer: -1,
        ),
      );
      expect(result.isFailure, isTrue);
    });

    test('rejects invalid model year', () {
      final Result<VehicleInput> result = VehicleValidator.validate(
        const VehicleInput(
          nickname: 'Bike',
          vehicleType: VehicleType.motorcycle,
          fuelType: FuelType.petrol,
          currentOdometer: 10,
          modelYear: 1800,
        ),
      );
      expect(result.isFailure, isTrue);
    });

    test('rejects negative purchase price', () {
      final Result<VehicleInput> result = VehicleValidator.validate(
        const VehicleInput(
          nickname: 'Bike',
          vehicleType: VehicleType.motorcycle,
          fuelType: FuelType.petrol,
          currentOdometer: 10,
          purchasePricePaisa: -100,
        ),
      );
      expect(result.isFailure, isTrue);
    });
  });
}
