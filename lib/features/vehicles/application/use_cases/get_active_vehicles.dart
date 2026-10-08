import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';

/// Example use-case convention: one public class, inject repository, return Result.
class GetActiveVehicles {
  const GetActiveVehicles(this._repository);

  final VehicleRepository _repository;

  Future<Result<List<Vehicle>>> call() => _repository.getActiveVehicles();
}
