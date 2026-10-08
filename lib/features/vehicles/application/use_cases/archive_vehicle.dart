import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';

class ArchiveVehicle {
  const ArchiveVehicle(this._repository);

  final VehicleRepository _repository;

  Future<Result<void>> call(String id) => _repository.archive(id);
}
