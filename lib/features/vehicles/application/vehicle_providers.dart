import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return DriftVehicleRepository(ref.watch(appDatabaseProvider));
});

final activeVehiclesProvider = FutureProvider<List<Vehicle>>((ref) async {
  final Result<List<Vehicle>> result = await ref
      .watch(vehicleRepositoryProvider)
      .getActiveVehicles();
  return result.when(
    success: (vehicles) => vehicles,
    failure: (error) => throw error,
  );
});

/// Placeholder selected vehicle ID restored from settings preferences.
final selectedVehicleIdProvider = Provider<String?>((ref) {
  return ref.watch(settingsControllerProvider).selectedVehicleId;
});

final selectedVehicleProvider = FutureProvider<Vehicle?>((ref) async {
  final String? id = ref.watch(selectedVehicleIdProvider);
  if (id == null) {
    final List<Vehicle> vehicles = await ref.watch(
      activeVehiclesProvider.future,
    );
    return vehicles.isEmpty ? null : vehicles.first;
  }
  final Result<Vehicle?> result = await ref
      .watch(vehicleRepositoryProvider)
      .getById(id);
  return result.when(
    success: (vehicle) => vehicle,
    failure: (error) => throw error,
  );
});
