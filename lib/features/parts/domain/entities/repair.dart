import 'package:garir_khata/features/parts/domain/warranty.dart';

class RepairPart {
  const RepairPart({
    required this.id,
    required this.repairId,
    required this.partName,
    required this.quantity,
    required this.unitCostPaisa,
    required this.totalCostPaisa,
    this.brand,
    this.partNumber,
    this.warrantyEndDate,
    this.note,
  });

  final String id;
  final String repairId;
  final String partName;
  final String? brand;
  final String? partNumber;
  final double quantity;
  final int unitCostPaisa;
  final int totalCostPaisa;
  final DateTime? warrantyEndDate;
  final String? note;

  WarrantyState get warranty => WarrantyCalculator.evaluate(warrantyEndDate);
}

class Repair {
  const Repair({
    required this.id,
    required this.vehicleId,
    required this.repairDate,
    required this.odometer,
    required this.category,
    required this.problemDescription,
    required this.laborCostPaisa,
    required this.partsCostPaisa,
    required this.totalCostPaisa,
    required this.createdAt,
    required this.updatedAt,
    this.diagnosis,
    this.workPerformed,
    this.vendorName,
    this.warrantyEndDate,
    this.followUpDate,
    this.note,
    this.parts = const [],
  });

  final String id;
  final String vehicleId;
  final DateTime repairDate;
  final int odometer;
  final String category;
  final String problemDescription;
  final String? diagnosis;
  final String? workPerformed;
  final String? vendorName;
  final int laborCostPaisa;
  final int partsCostPaisa;
  final int totalCostPaisa;
  final DateTime? warrantyEndDate;
  final DateTime? followUpDate;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RepairPart> parts;

  WarrantyState get warranty => WarrantyCalculator.evaluate(warrantyEndDate);
}
