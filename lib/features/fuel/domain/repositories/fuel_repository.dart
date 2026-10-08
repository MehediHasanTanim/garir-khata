import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

abstract interface class FuelRepository {
  Future<Result<List<FuelEntry>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  });

  Future<Result<FuelEntry?>> getById(String id);

  Future<Result<FuelEntry>> createWithOdometer({
    required FuelEntry fuel,
    required OdometerEntry odometerEntry,
  });

  Future<Result<FuelEntry>> updateWithOdometer({
    required FuelEntry fuel,
    required OdometerEntry odometerEntry,
  });

  Future<Result<void>> delete(String id);

  Future<Result<List<FuelEntry>>> findSimilar({
    required String vehicleId,
    required int odometer,
    required DateTime dateTime,
    required int totalCostPaisa,
    String? excludeId,
  });
}

/// Sprint 4 will create a real linked expense. Sprint 3 keeps a no-op hook.
abstract interface class FuelExpenseLinkService {
  Future<void> upsertLinkedExpense(ValidatedFuelInput input, String fuelId);
  Future<void> deleteLinkedExpense(String fuelId);
}

class NoOpFuelExpenseLinkService implements FuelExpenseLinkService {
  const NoOpFuelExpenseLinkService();

  @override
  Future<void> upsertLinkedExpense(ValidatedFuelInput input, String fuelId) async {}

  @override
  Future<void> deleteLinkedExpense(String fuelId) async {}
}
