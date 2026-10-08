class OilChange {
  const OilChange({
    required this.id,
    required this.vehicleId,
    required this.occurredOn,
    required this.odometer,
    required this.costPaisa,
    required this.filterChanged,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.productName,
    this.viscosity,
    this.quantityMl,
    this.vendorName,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
    this.serviceRecordId,
  });

  final String id;
  final String vehicleId;
  final DateTime occurredOn;
  final int odometer;
  final String? brand;
  final String? productName;
  final String? viscosity;
  final int? quantityMl;
  final int costPaisa;
  final bool filterChanged;
  final String? vendorName;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
  final String? serviceRecordId;
  final DateTime createdAt;
  final DateTime updatedAt;

  double get costMajor => costPaisa / 100.0;
  double? get quantityLiters =>
      quantityMl == null ? null : quantityMl! / 1000.0;

  String get displayLabel {
    final parts = <String>[
      if (brand != null && brand!.isNotEmpty) brand!,
      if (productName != null && productName!.isNotEmpty) productName!,
      if (viscosity != null && viscosity!.isNotEmpty) viscosity!,
    ];
    return parts.isEmpty ? 'Engine oil' : parts.join(' ');
  }
}
