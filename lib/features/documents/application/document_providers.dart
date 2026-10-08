import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/documents/application/use_cases/add_document.dart';
import 'package:garir_khata/features/documents/data/repositories/drift_document_repository.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';
import 'package:garir_khata/features/documents/domain/repositories/document_repository.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DriftDocumentRepository(ref.watch(appDatabaseProvider));
});

final addDocumentProvider = Provider<AddDocument>((ref) {
  return AddDocument(
    documentRepository: ref.watch(documentRepositoryProvider),
    reminderRepository: ref.watch(reminderRepositoryProvider),
    reminderEngine: ref.watch(reminderEngineProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final selectedVehicleDocumentsProvider =
    FutureProvider<List<VehicleDocument>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  final Result<List<VehicleDocument>> result =
      await ref.watch(documentRepositoryProvider).getForVehicle(vehicle.id);
  return result.when(
    success: (docs) => docs,
    failure: (error) => throw error,
  );
});

final documentByIdProvider =
    FutureProvider.family<VehicleDocument?, String>((ref, id) async {
  final Result<VehicleDocument?> result =
      await ref.watch(documentRepositoryProvider).getById(id);
  return result.when(
    success: (doc) => doc,
    failure: (error) => throw error,
  );
});
