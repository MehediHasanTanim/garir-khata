enum DueUrgency { ok, soon, overdue, unknown }

class NextDueSuggestion {
  const NextDueSuggestion({
    this.nextDueDate,
    this.nextDueOdometer,
  });

  final DateTime? nextDueDate;
  final int? nextDueOdometer;
}

class DueStatus {
  const DueStatus({
    required this.urgency,
    this.remainingKm,
    this.remainingDays,
    this.explanation,
  });

  final DueUrgency urgency;
  final int? remainingKm;
  final int? remainingDays;
  final String? explanation;

  bool get isDueSoonOrOverdue =>
      urgency == DueUrgency.soon || urgency == DueUrgency.overdue;
}

/// Computes next-due and remaining distance/time for maintenance items.
abstract final class NextDueCalculator {
  static const int soonKmThreshold = 500;
  static const int soonDayThreshold = 30;

  static NextDueSuggestion suggest({
    required int performedOdometer,
    required DateTime performedAt,
    int? kmInterval,
    int? dayInterval,
  }) {
    return NextDueSuggestion(
      nextDueOdometer:
          kmInterval == null ? null : performedOdometer + kmInterval,
      nextDueDate: dayInterval == null
          ? null
          : performedAt.add(Duration(days: dayInterval)),
    );
  }

  static DueStatus evaluate({
    required int currentOdometer,
    required DateTime now,
    int? nextDueOdometer,
    DateTime? nextDueDate,
  }) {
    if (nextDueOdometer == null && nextDueDate == null) {
      return const DueStatus(
        urgency: DueUrgency.unknown,
        explanation: 'No due schedule set',
      );
    }

    final int? remainingKm =
        nextDueOdometer == null ? null : nextDueOdometer - currentOdometer;
    final int? remainingDays = nextDueDate?.difference(DateTime(now.year, now.month, now.day)).inDays;

    final bool overdueKm = remainingKm != null && remainingKm <= 0;
    final bool overdueDays = remainingDays != null && remainingDays <= 0;
    if (overdueKm || overdueDays) {
      return DueStatus(
        urgency: DueUrgency.overdue,
        remainingKm: remainingKm,
        remainingDays: remainingDays,
        explanation: 'Overdue',
      );
    }

    final bool soonKm =
        remainingKm != null && remainingKm <= soonKmThreshold;
    final bool soonDays =
        remainingDays != null && remainingDays <= soonDayThreshold;
    if (soonKm || soonDays) {
      return DueStatus(
        urgency: DueUrgency.soon,
        remainingKm: remainingKm,
        remainingDays: remainingDays,
        explanation: 'Due soon',
      );
    }

    return DueStatus(
      urgency: DueUrgency.ok,
      remainingKm: remainingKm,
      remainingDays: remainingDays,
      explanation: 'On time',
    );
  }

  /// Average km interval between chronological oil changes.
  static double? averageOilIntervalKm(List<int> odometersAscending) {
    if (odometersAscending.length < 2) {
      return null;
    }
    int total = 0;
    int count = 0;
    for (int i = 1; i < odometersAscending.length; i++) {
      final int delta = odometersAscending[i] - odometersAscending[i - 1];
      if (delta > 0) {
        total += delta;
        count++;
      }
    }
    if (count == 0) {
      return null;
    }
    return total / count;
  }
}

abstract final class ServiceCostCalculator {
  static int totalPaisa({required int laborPaisa, required int partsPaisa}) {
    final int labor = laborPaisa < 0 ? 0 : laborPaisa;
    final int parts = partsPaisa < 0 ? 0 : partsPaisa;
    return labor + parts;
  }
}
