import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';

abstract interface class ServiceRepository {
  Future<Result<List<MaintenanceTemplate>>> getTemplates({String? vehicleType});

  Future<Result<MaintenanceTemplate?>> getTemplateByCode({
    required String code,
    required String vehicleType,
  });

  Future<Result<List<ServiceRecord>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  });

  Future<Result<ServiceRecord?>> getById(String id);

  Future<Result<ServiceRecord>> createWithItems(ServiceRecord record);

  Future<Result<ServiceRecord>> updateWithItems(ServiceRecord record);

  Future<Result<void>> delete(String id);

  Future<Result<List<DueServiceItem>>> getDueServices({
    required String vehicleId,
    required int currentOdometer,
    DateTime? now,
  });
}
