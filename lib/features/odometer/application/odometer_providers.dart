import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/odometer/application/use_cases/add_odometer_reading.dart';
import 'package:garir_khata/features/odometer/data/repositories/drift_odometer_repository.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/odometer/domain/repositories/odometer_repository.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final odometerRepositoryProvider = Provider<OdometerRepository>((ref) {
  return DriftOdometerRepository(ref.watch(appDatabaseProvider));
});

final addOdometerReadingProvider = Provider<AddOdometerReading>((ref) {
  return AddOdometerReading(
    repository: ref.watch(odometerRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final odometerHistoryProvider =
    FutureProvider.family<List<OdometerEntry>, String>((ref, vehicleId) async {
  final Result<List<OdometerEntry>> result =
      await ref.watch(odometerRepositoryProvider).getHistory(vehicleId);
  return result.when(
    success: (entries) => entries,
    failure: (error) => throw error,
  );
});

final selectedVehicleOdometerHistoryProvider =
    FutureProvider<List<OdometerEntry>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  return ref.watch(odometerHistoryProvider(vehicle.id).future);
});
