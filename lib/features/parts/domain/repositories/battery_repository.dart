import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/domain/entities/battery.dart';

abstract interface class BatteryRepository {
  Future<Result<Battery?>> getActive(String vehicleId);
  Future<Result<List<Battery>>> getHistory(String vehicleId);
  Future<Result<Battery?>> getById(String id);
  Future<Result<Battery>> create(Battery battery);
  Future<Result<Battery>> replace({
    required Battery oldBattery,
    required Battery newBattery,
  });
  Future<Result<Battery>> markRemoved(Battery battery);
  Future<Result<void>> delete(String id);
}
