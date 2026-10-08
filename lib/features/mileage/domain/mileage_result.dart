enum MileageStatus {
  available,
  insufficientData,
  invalidOdometer,
  invalidFuelData,
  zeroFuel,
}

class MileageInterval {
  const MileageInterval({
    required this.status,
    required this.startEntryId,
    required this.endEntryId,
    required this.startOdometer,
    required this.endOdometer,
    required this.distanceKm,
    required this.fuelConsumedMl,
    required this.mileageKmPerLiter,
    this.explanation,
  });

  final MileageStatus status;
  final String startEntryId;
  final String endEntryId;
  final int startOdometer;
  final int endOdometer;
  final int distanceKm;
  final int fuelConsumedMl;
  final double? mileageKmPerLiter;
  final String? explanation;

  bool get isAvailable => status == MileageStatus.available;

  double get fuelConsumedLiters => fuelConsumedMl / 1000.0;
}

class MileageAggregate {
  const MileageAggregate({
    required this.status,
    required this.intervals,
    required this.totalDistanceKm,
    required this.totalFuelMl,
    required this.averageMileageKmPerLiter,
    this.explanation,
  });

  final MileageStatus status;
  final List<MileageInterval> intervals;
  final int totalDistanceKm;
  final int totalFuelMl;
  final double? averageMileageKmPerLiter;
  final String? explanation;

  bool get isAvailable => status == MileageStatus.available;

  double get totalFuelLiters => totalFuelMl / 1000.0;

  static const MileageAggregate insufficient = MileageAggregate(
    status: MileageStatus.insufficientData,
    intervals: [],
    totalDistanceKm: 0,
    totalFuelMl: 0,
    averageMileageKmPerLiter: null,
    explanation: 'Need at least two full-tank entries',
  );
}
