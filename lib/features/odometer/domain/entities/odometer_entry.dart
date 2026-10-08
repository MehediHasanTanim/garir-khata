enum OdometerSourceType {
  manual,
  fuel,
  service,
  repair,
  oilChange,
  reset,
  import,
}

class OdometerEntry {
  const OdometerEntry({
    required this.id,
    required this.vehicleId,
    required this.recordedAt,
    required this.odometer,
    required this.sourceType,
    required this.isManualCorrection,
    required this.isDiscontinuity,
    required this.createdAt,
    this.sourceRecordId,
    this.note,
  });

  final String id;
  final String vehicleId;
  final DateTime recordedAt;
  final int odometer;
  final OdometerSourceType sourceType;
  final String? sourceRecordId;
  final String? note;
  final bool isManualCorrection;
  final bool isDiscontinuity;
  final DateTime createdAt;
}
