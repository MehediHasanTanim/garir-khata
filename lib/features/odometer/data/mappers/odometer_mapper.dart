import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

abstract final class OdometerMapper {
  static OdometerEntry toDomain(OdometerEntryRow row) {
    return OdometerEntry(
      id: row.id,
      vehicleId: row.vehicleId,
      recordedAt: row.recordedAt,
      odometer: row.odometer,
      sourceType: OdometerSourceType.values.byName(row.sourceType),
      sourceRecordId: row.sourceRecordId,
      note: row.note,
      isManualCorrection: row.isManualCorrection,
      isDiscontinuity: row.isDiscontinuity,
      createdAt: row.createdAt,
    );
  }

  static OdometerEntriesCompanion toCompanion(OdometerEntry entry) {
    return OdometerEntriesCompanion.insert(
      id: entry.id,
      vehicleId: entry.vehicleId,
      recordedAt: entry.recordedAt,
      odometer: entry.odometer,
      sourceType: entry.sourceType.name,
      sourceRecordId: Value(entry.sourceRecordId),
      note: Value(entry.note),
      isManualCorrection: Value(entry.isManualCorrection),
      isDiscontinuity: Value(entry.isDiscontinuity),
      createdAt: entry.createdAt,
    );
  }
}
