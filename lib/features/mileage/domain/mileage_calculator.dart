import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';

/// Tank-to-tank mileage: distance between consecutive full tanks divided by
/// all fuel added after the start full tank through the end full tank
/// (partials + end fill).
abstract final class MileageCalculator {
  static List<MileageInterval> calculateIntervals(List<FuelEntry> entries) {
    if (entries.isEmpty) {
      return const [];
    }

    final List<FuelEntry> ordered = List<FuelEntry>.of(entries)
      ..sort((a, b) {
        final int byOdo = a.odometer.compareTo(b.odometer);
        if (byOdo != 0) {
          return byOdo;
        }
        return a.dateTime.compareTo(b.dateTime);
      });

    final List<int> fullIndexes = <int>[];
    for (int i = 0; i < ordered.length; i++) {
      if (ordered[i].isFullTank) {
        fullIndexes.add(i);
      }
    }

    if (fullIndexes.length < 2) {
      return const [];
    }

    final List<MileageInterval> intervals = <MileageInterval>[];
    for (int f = 0; f < fullIndexes.length - 1; f++) {
      final int startIdx = fullIndexes[f];
      final int endIdx = fullIndexes[f + 1];
      intervals.add(_interval(ordered, startIdx, endIdx));
    }
    return intervals;
  }

  static MileageAggregate aggregate(List<FuelEntry> entries) {
    final List<MileageInterval> intervals = calculateIntervals(entries);
    if (intervals.isEmpty) {
      return MileageAggregate.insufficient;
    }

    final List<MileageInterval> valid =
        intervals.where((i) => i.isAvailable).toList();
    if (valid.isEmpty) {
      final MileageInterval first = intervals.first;
      return MileageAggregate(
        status: first.status,
        intervals: intervals,
        totalDistanceKm: 0,
        totalFuelMl: 0,
        averageMileageKmPerLiter: null,
        explanation: first.explanation,
      );
    }

    final int distance =
        valid.fold<int>(0, (sum, i) => sum + i.distanceKm);
    final int fuel = valid.fold<int>(0, (sum, i) => sum + i.fuelConsumedMl);
    final double? mileage =
        fuel <= 0 ? null : distance / (fuel / 1000.0);

    return MileageAggregate(
      status: MileageStatus.available,
      intervals: intervals,
      totalDistanceKm: distance,
      totalFuelMl: fuel,
      averageMileageKmPerLiter: mileage,
    );
  }

  /// Latest completed tank-to-tank interval (for dashboard “current mileage”).
  static MileageInterval? latestAvailable(List<FuelEntry> entries) {
    final List<MileageInterval> intervals = calculateIntervals(entries);
    for (int i = intervals.length - 1; i >= 0; i--) {
      if (intervals[i].isAvailable) {
        return intervals[i];
      }
    }
    return null;
  }

  static MileageInterval _interval(
    List<FuelEntry> ordered,
    int startIdx,
    int endIdx,
  ) {
    final FuelEntry start = ordered[startIdx];
    final FuelEntry end = ordered[endIdx];
    final int distance = end.odometer - start.odometer;

    if (distance <= 0) {
      return MileageInterval(
        status: MileageStatus.invalidOdometer,
        startEntryId: start.id,
        endEntryId: end.id,
        startOdometer: start.odometer,
        endOdometer: end.odometer,
        distanceKm: distance,
        fuelConsumedMl: 0,
        mileageKmPerLiter: null,
        explanation: 'Odometer did not increase between full tanks',
      );
    }

    int fuelMl = 0;
    for (int i = startIdx + 1; i <= endIdx; i++) {
      fuelMl += ordered[i].quantityMl;
    }

    if (fuelMl <= 0) {
      return MileageInterval(
        status: MileageStatus.zeroFuel,
        startEntryId: start.id,
        endEntryId: end.id,
        startOdometer: start.odometer,
        endOdometer: end.odometer,
        distanceKm: distance,
        fuelConsumedMl: 0,
        mileageKmPerLiter: null,
        explanation: 'No fuel quantity between full tanks',
      );
    }

    final double liters = fuelMl / 1000.0;
    return MileageInterval(
      status: MileageStatus.available,
      startEntryId: start.id,
      endEntryId: end.id,
      startOdometer: start.odometer,
      endOdometer: end.odometer,
      distanceKm: distance,
      fuelConsumedMl: fuelMl,
      mileageKmPerLiter: distance / liters,
    );
  }
}
