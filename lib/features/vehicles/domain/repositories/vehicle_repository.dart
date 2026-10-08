import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

abstract interface class VehicleRepository {
  Future<Result<List<Vehicle>>> getActiveVehicles();
  Future<Result<Vehicle?>> getById(String id);
  Future<Result<Vehicle>> upsert(Vehicle vehicle);
  Future<Result<void>> archive(String id);
}
