import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/application/use_cases/delete_fuel_entry.dart';
import 'package:garir_khata/features/fuel/application/use_cases/update_fuel_entry.dart';
import 'package:garir_khata/features/fuel/data/repositories/drift_fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/odometer/application/odometer_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final fuelRepositoryProvider = Provider<FuelRepository>((ref) {
  return DriftFuelRepository(ref.watch(appDatabaseProvider));
});

final fuelExpenseLinkProvider = Provider<FuelExpenseLinkService>((ref) {
  return ref.watch(fuelExpenseLinkServiceProvider);
});

final addFuelEntryProvider = Provider<AddFuelEntry>((ref) {
  return AddFuelEntry(
    fuelRepository: ref.watch(fuelRepositoryProvider),
    odometerRepository: ref.watch(odometerRepositoryProvider),
    expenseLink: ref.watch(fuelExpenseLinkProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final updateFuelEntryProvider = Provider<UpdateFuelEntry>((ref) {
  return UpdateFuelEntry(
    fuelRepository: ref.watch(fuelRepositoryProvider),
    expenseLink: ref.watch(fuelExpenseLinkProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final deleteFuelEntryProvider = Provider<DeleteFuelEntry>((ref) {
  return DeleteFuelEntry(
    fuelRepository: ref.watch(fuelRepositoryProvider),
    expenseLink: ref.watch(fuelExpenseLinkProvider),
  );
});

final fuelHistoryProvider =
    FutureProvider.family<List<FuelEntry>, String>((ref, vehicleId) async {
  final Result<List<FuelEntry>> result =
      await ref.watch(fuelRepositoryProvider).getHistory(vehicleId);
  return result.when(
    success: (entries) => entries,
    failure: (error) => throw error,
  );
});

final fuelEntryProvider =
    FutureProvider.family<FuelEntry?, String>((ref, id) async {
  final Result<FuelEntry?> result =
      await ref.watch(fuelRepositoryProvider).getById(id);
  return result.when(
    success: (entry) => entry,
    failure: (error) => throw error,
  );
});

final selectedVehicleFuelHistoryProvider =
    FutureProvider<List<FuelEntry>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  return ref.watch(fuelHistoryProvider(vehicle.id).future);
});
