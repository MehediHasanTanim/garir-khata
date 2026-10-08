import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';

abstract interface class VehiclePartRepository {
  Future<Result<List<VehiclePart>>> getActive(String vehicleId);
  Future<Result<VehiclePart?>> getById(String id);
  Future<Result<VehiclePart>> create(VehiclePart part);
  Future<Result<VehiclePart>> update(VehiclePart part);
  Future<Result<void>> delete(String id);
}
