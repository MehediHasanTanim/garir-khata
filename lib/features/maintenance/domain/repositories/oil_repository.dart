import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

class OilChangeBundle {
  const OilChangeBundle({
    required this.oilChange,
    this.serviceRecord,
    this.odometerEntry,
  });

  final OilChange oilChange;
  final ServiceRecord? serviceRecord;
  final OdometerEntry? odometerEntry;
}

abstract interface class OilRepository {
  Future<Result<List<OilChange>>> getHistory(
    String vehicleId, {
    int limit = 50,
    int offset = 0,
  });

  Future<Result<OilChange?>> getById(String id);

  Future<Result<OilChange?>> getLatest(String vehicleId);

  Future<Result<OilChange>> createBundle(OilChangeBundle bundle);

  Future<Result<OilChange>> update(OilChange oilChange);

  Future<Result<void>> delete(String id);
}
