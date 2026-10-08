import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';

abstract interface class RepairRepository {
  Future<Result<List<Repair>>> getHistory(String vehicleId, {int limit = 50});
  Future<Result<Repair?>> getById(String id);
  Future<Result<Repair>> createWithParts(Repair repair);
  Future<Result<Repair>> updateWithParts(Repair repair);
  Future<Result<void>> delete(String id);
}
