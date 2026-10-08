enum WarrantyStatus { active, expiringSoon, expired, unknown }

class WarrantyState {
  const WarrantyState({
    required this.status,
    this.warrantyEndDate,
    this.daysRemaining,
  });

  final WarrantyStatus status;
  final DateTime? warrantyEndDate;
  final int? daysRemaining;

  bool get isKnown => status != WarrantyStatus.unknown;
}

/// Shared warranty evaluation for repairs, parts, tyres, and batteries.
abstract final class WarrantyCalculator {
  static const int expiringSoonDays = 30;

  static WarrantyState evaluate(DateTime? warrantyEndDate, {DateTime? now}) {
    if (warrantyEndDate == null) {
      return const WarrantyState(status: WarrantyStatus.unknown);
    }
    final DateTime today = now ?? DateTime.now();
    final DateTime end = DateTime(
      warrantyEndDate.year,
      warrantyEndDate.month,
      warrantyEndDate.day,
    );
    final DateTime anchor = DateTime(today.year, today.month, today.day);
    final int days = end.difference(anchor).inDays;

    if (days < 0) {
      return WarrantyState(
        status: WarrantyStatus.expired,
        warrantyEndDate: end,
        daysRemaining: days,
      );
    }
    if (days <= expiringSoonDays) {
      return WarrantyState(
        status: WarrantyStatus.expiringSoon,
        warrantyEndDate: end,
        daysRemaining: days,
      );
    }
    return WarrantyState(
      status: WarrantyStatus.active,
      warrantyEndDate: end,
      daysRemaining: days,
    );
  }
}
