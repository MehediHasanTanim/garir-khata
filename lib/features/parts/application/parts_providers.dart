import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/parts/application/use_cases/add_repair.dart';
import 'package:garir_khata/features/parts/application/use_cases/delete_repair.dart';
import 'package:garir_khata/features/parts/data/repair_expense_link.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_battery_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_repair_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_tyre_repository.dart';
import 'package:garir_khata/features/parts/data/repositories/drift_vehicle_part_repository.dart';
import 'package:garir_khata/features/parts/domain/entities/battery.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';
import 'package:garir_khata/features/parts/domain/repositories/battery_repository.dart';
import 'package:garir_khata/features/parts/domain/repositories/repair_repository.dart';
import 'package:garir_khata/features/parts/domain/repositories/tyre_repository.dart';
import 'package:garir_khata/features/parts/domain/repositories/vehicle_part_repository.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final repairRepositoryProvider = Provider<RepairRepository>((ref) {
  return DriftRepairRepository(ref.watch(appDatabaseProvider));
});

final vehiclePartRepositoryProvider = Provider<VehiclePartRepository>((ref) {
  return DriftVehiclePartRepository(ref.watch(appDatabaseProvider));
});

final tyreRepositoryProvider = Provider<TyreRepository>((ref) {
  return DriftTyreRepository(ref.watch(appDatabaseProvider));
});

final batteryRepositoryProvider = Provider<BatteryRepository>((ref) {
  return DriftBatteryRepository(ref.watch(appDatabaseProvider));
});

final repairExpenseLinkProvider = Provider<RepairExpenseLink>((ref) {
  return RepairExpenseLink(
    expenseRepository: ref.watch(expenseRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final addRepairProvider = Provider<AddRepair>((ref) {
  return AddRepair(
    repository: ref.watch(repairRepositoryProvider),
    expenseLink: ref.watch(repairExpenseLinkProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final deleteRepairProvider = Provider<DeleteRepair>((ref) {
  return DeleteRepair(
    repository: ref.watch(repairRepositoryProvider),
    expenseLink: ref.watch(repairExpenseLinkProvider),
  );
});

final selectedVehicleRepairHistoryProvider =
    FutureProvider<List<Repair>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final Result<List<Repair>> result =
      await ref.watch(repairRepositoryProvider).getHistory(vehicle.id);
  return result.when(
    success: (repairs) => repairs,
    failure: (error) => throw error,
  );
});

final repairByIdProvider =
    FutureProvider.family<Repair?, String>((ref, id) async {
  final Result<Repair?> result =
      await ref.watch(repairRepositoryProvider).getById(id);
  return result.when(
    success: (repair) => repair,
    failure: (error) => throw error,
  );
});

final selectedVehiclePartsProvider =
    FutureProvider<List<VehiclePart>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final Result<List<VehiclePart>> result =
      await ref.watch(vehiclePartRepositoryProvider).getActive(vehicle.id);
  return result.when(
    success: (parts) => parts,
    failure: (error) => throw error,
  );
});

final vehiclePartByIdProvider =
    FutureProvider.family<VehiclePart?, String>((ref, id) async {
  final Result<VehiclePart?> result =
      await ref.watch(vehiclePartRepositoryProvider).getById(id);
  return result.when(
    success: (part) => part,
    failure: (error) => throw error,
  );
});

final selectedVehicleActiveTyresProvider =
    FutureProvider<List<Tyre>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final Result<List<Tyre>> result =
      await ref.watch(tyreRepositoryProvider).getActive(vehicle.id);
  return result.when(
    success: (tyres) => tyres,
    failure: (error) => throw error,
  );
});

final tyreByIdProvider = FutureProvider.family<Tyre?, String>((ref, id) async {
  final Result<Tyre?> result = await ref.watch(tyreRepositoryProvider).getById(id);
  return result.when(
    success: (tyre) => tyre,
    failure: (error) => throw error,
  );
});

final selectedVehicleActiveBatteryProvider =
    FutureProvider<Battery?>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return null;
  }
  final Result<Battery?> result =
      await ref.watch(batteryRepositoryProvider).getActive(vehicle.id);
  return result.when(
    success: (battery) => battery,
    failure: (error) => throw error,
  );
});

final selectedVehicleBatteryHistoryProvider =
    FutureProvider<List<Battery>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final Result<List<Battery>> result =
      await ref.watch(batteryRepositoryProvider).getHistory(vehicle.id);
  return result.when(
    success: (batteries) => batteries,
    failure: (error) => throw error,
  );
});

final batteryByIdProvider =
    FutureProvider.family<Battery?, String>((ref, id) async {
  final Result<Battery?> result =
      await ref.watch(batteryRepositoryProvider).getById(id);
  return result.when(
    success: (battery) => battery,
    failure: (error) => throw error,
  );
});
