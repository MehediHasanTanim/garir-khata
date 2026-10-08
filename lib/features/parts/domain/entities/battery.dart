import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/domain/warranty.dart';

class Battery {
  const Battery({
    required this.id,
    required this.vehicleId,
    required this.installDate,
    required this.costPaisa,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.model,
    this.specification,
    this.purchaseDate,
    this.installOdometer,
    this.warrantyEndDate,
    this.vendorName,
    this.note,
  });

  final String id;
  final String vehicleId;
  final String? brand;
  final String? model;
  final String? specification;
  final DateTime? purchaseDate;
  final DateTime installDate;
  final int? installOdometer;
  final int costPaisa;
  final DateTime? warrantyEndDate;
  final String? vendorName;
  final BatteryStatus status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  WarrantyState get warranty => WarrantyCalculator.evaluate(warrantyEndDate);

  String get displayLabel {
    final parts = <String>[
      if (brand != null && brand!.isNotEmpty) brand!,
      if (model != null && model!.isNotEmpty) model!,
    ];
    return parts.isEmpty ? 'Battery' : parts.join(' ');
  }
}
