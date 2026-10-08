import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/archive_vehicle.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/update_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return DriftVehicleRepository(ref.watch(appDatabaseProvider));
});

final addVehicleProvider = Provider<AddVehicle>((ref) {
  return AddVehicle(
    repository: ref.watch(vehicleRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final updateVehicleProvider = Provider<UpdateVehicle>((ref) {
  return UpdateVehicle(
    repository: ref.watch(vehicleRepositoryProvider),
    clock: ref.watch(clockProvider),
  );
});

final archiveVehicleProvider = Provider<ArchiveVehicle>((ref) {
  return ArchiveVehicle(ref.watch(vehicleRepositoryProvider));
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

final selectedVehicleIdProvider = Provider<String?>((ref) {
  return ref.watch(settingsControllerProvider).selectedVehicleId;
});

final selectedVehicleProvider = FutureProvider<Vehicle?>((ref) async {
  final List<Vehicle> vehicles = await ref.watch(activeVehiclesProvider.future);
  if (vehicles.isEmpty) {
    return null;
  }

  final String? id = ref.watch(selectedVehicleIdProvider);
  if (id != null) {
    for (final Vehicle vehicle in vehicles) {
      if (vehicle.id == id) {
        return vehicle;
      }
    }
    // Selected vehicle was archived/removed — fall back and persist.
    await ref
        .read(settingsControllerProvider.notifier)
        .setSelectedVehicleId(vehicles.first.id);
  } else {
    await ref
        .read(settingsControllerProvider.notifier)
        .setSelectedVehicleId(vehicles.first.id);
  }
  return vehicles.first;
});

final vehicleByIdProvider = FutureProvider.family<Vehicle?, String>((
  ref,
  id,
) async {
  final Result<Vehicle?> result = await ref
      .watch(vehicleRepositoryProvider)
      .getById(id);
  return result.when(
    success: (vehicle) => vehicle,
    failure: (error) => throw error,
  );
});

Future<Result<void>> selectVehicle(WidgetRef ref, String vehicleId) async {
  await ref
      .read(settingsControllerProvider.notifier)
      .setSelectedVehicleId(vehicleId);
  ref.invalidate(selectedVehicleProvider);
  return const Success(null);
}

Future<Result<Vehicle>> saveNewVehicle(
  WidgetRef ref,
  VehicleInput input,
) async {
  final Result<Vehicle> result = await ref.read(addVehicleProvider)(input);
  if (result case Success(:final data)) {
    await ref
        .read(settingsControllerProvider.notifier)
        .setSelectedVehicleId(data.id);
    ref.invalidate(activeVehiclesProvider);
    ref.invalidate(selectedVehicleProvider);
  }
  return result;
}

Future<Result<Vehicle>> saveExistingVehicle(
  WidgetRef ref, {
  required String id,
  required VehicleInput input,
}) async {
  final Result<Vehicle> result = await ref.read(updateVehicleProvider)(
    id: id,
    input: input,
  );
  if (result.isSuccess) {
    ref.invalidate(activeVehiclesProvider);
    ref.invalidate(selectedVehicleProvider);
    ref.invalidate(vehicleByIdProvider(id));
  }
  return result;
}

Future<Result<void>> archiveSelectedVehicle(WidgetRef ref, String id) async {
  final Result<void> result = await ref.read(archiveVehicleProvider)(id);
  if (result.isSuccess) {
    final String? selected = ref
        .read(settingsControllerProvider)
        .selectedVehicleId;
    if (selected == id) {
      await ref
          .read(settingsControllerProvider.notifier)
          .setSelectedVehicleId(null);
    }
    ref.invalidate(activeVehiclesProvider);
    ref.invalidate(selectedVehicleProvider);
  }
  return result;
}
