import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

abstract interface class OdometerRepository {
  Future<Result<OdometerEntry?>> getLatest(String vehicleId);
  Future<Result<List<OdometerEntry>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  });
  Future<Result<OdometerEntry>> insert(OdometerEntry entry);
  Future<Result<void>> deleteBySource({
    required String sourceType,
    required String sourceRecordId,
  });
  Future<Result<int?>> recalculateVehicleCurrentOdometer(String vehicleId);
}
