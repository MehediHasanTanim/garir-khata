import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';

abstract interface class DocumentRepository {
  Future<Result<List<VehicleDocument>>> getForVehicle(String vehicleId);
  Future<Result<List<VehicleDocument>>> getExpiring({
    required String vehicleId,
    required DateTime before,
  });
  Future<Result<VehicleDocument?>> getById(String id);
  Future<Result<VehicleDocument>> create(VehicleDocument document);
  Future<Result<VehicleDocument>> update(VehicleDocument document);
  Future<Result<void>> delete(String id);
}
