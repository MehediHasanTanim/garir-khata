class VehicleDocument {
  const VehicleDocument({
    required this.id,
    required this.vehicleId,
    required this.documentType,
    required this.feePaisa,
    required this.createdAt,
    required this.updatedAt,
    this.documentNumber,
    this.issueDate,
    this.expiryDate,
    this.issuingAuthority,
    this.providerName,
    this.policyNumber,
    this.coverageType,
    this.ownerName,
    this.note,
  });

  final String id;
  final String vehicleId;
  final String documentType;
  final String? documentNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final int feePaisa;
  final String? issuingAuthority;
  final String? providerName;
  final String? policyNumber;
  final String? coverageType;
  final String? ownerName;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get hasExpiry => expiryDate != null;

  int? daysUntilExpiry({DateTime? now}) {
    if (expiryDate == null) {
      return null;
    }
    final DateTime today = _dateOnly(now ?? DateTime.now());
    final DateTime end = _dateOnly(expiryDate!);
    return end.difference(today).inDays;
  }

  static DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
