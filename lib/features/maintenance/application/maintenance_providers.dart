import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/add_service.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/delete_oil_change.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/delete_service.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/record_oil_change.dart';
import 'package:garir_khata/features/maintenance/application/use_cases/update_service.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_oil_repository.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_service_repository.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/oil_repository.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/service_repository.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return DriftServiceRepository(ref.watch(appDatabaseProvider));
});

final oilRepositoryProvider = Provider<OilRepository>((ref) {
  return DriftOilRepository(ref.watch(appDatabaseProvider));
});

final serviceExpenseLinkProvider = Provider<ServiceExpenseLink>((ref) {
  return ServiceExpenseLink(
    expenseRepository: ref.watch(expenseRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final addServiceProvider = Provider<AddService>((ref) {
  return AddService(
    repository: ref.watch(serviceRepositoryProvider),
    expenseLink: ref.watch(serviceExpenseLinkProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final updateServiceProvider = Provider<UpdateService>((ref) {
  return UpdateService(
    repository: ref.watch(serviceRepositoryProvider),
    expenseLink: ref.watch(serviceExpenseLinkProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final deleteServiceProvider = Provider<DeleteService>((ref) {
  return DeleteService(
    repository: ref.watch(serviceRepositoryProvider),
    expenseLink: ref.watch(serviceExpenseLinkProvider),
  );
});

final recordOilChangeProvider = Provider<RecordOilChange>((ref) {
  return RecordOilChange(
    oilRepository: ref.watch(oilRepositoryProvider),
    serviceRepository: ref.watch(serviceRepositoryProvider),
    expenseLink: ref.watch(serviceExpenseLinkProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final deleteOilChangeProvider = Provider<DeleteOilChange>((ref) {
  return DeleteOilChange(
    repository: ref.watch(oilRepositoryProvider),
    expenseLink: ref.watch(serviceExpenseLinkProvider),
  );
});

String _vehicleTypeKey(VehicleType type) {
  return switch (type) {
    VehicleType.motorcycle || VehicleType.scooter => 'motorcycle',
    VehicleType.car ||
    VehicleType.suv ||
    VehicleType.microbus ||
    VehicleType.pickup =>
      'car',
    _ => 'motorcycle',
  };
}

final maintenanceTemplatesProvider =
    FutureProvider<List<MaintenanceTemplate>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  final String? type =
      vehicle == null ? null : _vehicleTypeKey(vehicle.vehicleType);
  final Result<List<MaintenanceTemplate>> result =
      await ref.watch(serviceRepositoryProvider).getTemplates(vehicleType: type);
  return result.when(
    success: (templates) => templates,
    failure: (error) => throw error,
  );
});

final serviceHistoryProvider =
    FutureProvider.family<List<ServiceRecord>, String>((ref, vehicleId) async {
  final Result<List<ServiceRecord>> result =
      await ref.watch(serviceRepositoryProvider).getHistory(vehicleId);
  return result.when(
    success: (records) => records,
    failure: (error) => throw error,
  );
});

final serviceByIdProvider =
    FutureProvider.family<ServiceRecord?, String>((ref, id) async {
  final Result<ServiceRecord?> result =
      await ref.watch(serviceRepositoryProvider).getById(id);
  return result.when(
    success: (record) => record,
    failure: (error) => throw error,
  );
});

final selectedVehicleServiceHistoryProvider =
    FutureProvider<List<ServiceRecord>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  return ref.watch(serviceHistoryProvider(vehicle.id).future);
});

final oilHistoryProvider =
    FutureProvider.family<List<OilChange>, String>((ref, vehicleId) async {
  final Result<List<OilChange>> result =
      await ref.watch(oilRepositoryProvider).getHistory(vehicleId);
  return result.when(
    success: (records) => records,
    failure: (error) => throw error,
  );
});

final oilByIdProvider =
    FutureProvider.family<OilChange?, String>((ref, id) async {
  final Result<OilChange?> result =
      await ref.watch(oilRepositoryProvider).getById(id);
  return result.when(
    success: (oil) => oil,
    failure: (error) => throw error,
  );
});

final selectedVehicleOilHistoryProvider =
    FutureProvider<List<OilChange>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  return ref.watch(oilHistoryProvider(vehicle.id).future);
});

final dueServicesProvider = FutureProvider<List<DueServiceItem>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final Result<List<DueServiceItem>> result =
      await ref.watch(serviceRepositoryProvider).getDueServices(
            vehicleId: vehicle.id,
            currentOdometer: vehicle.currentOdometer,
          );
  return result.when(
    success: (items) => items,
    failure: (error) => throw error,
  );
});
