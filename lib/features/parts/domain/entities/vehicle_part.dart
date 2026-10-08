import 'package:garir_khata/features/parts/domain/warranty.dart';

class VehiclePart {
  const VehiclePart({
    required this.id,
    required this.vehicleId,
    required this.category,
    required this.name,
    required this.installedDate,
    required this.costPaisa,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.partNumber,
    this.installedOdometer,
    this.vendorName,
    this.warrantyEndDate,
    this.replacementIntervalKm,
    this.replacementIntervalDays,
    this.note,
  });

  final String id;
  final String vehicleId;
  final String category;
  final String name;
  final String? brand;
  final String? partNumber;
  final DateTime installedDate;
  final int? installedOdometer;
  final int costPaisa;
  final String? vendorName;
  final DateTime? warrantyEndDate;
  final int? replacementIntervalKm;
  final int? replacementIntervalDays;
  final String? note;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  WarrantyState get warranty => WarrantyCalculator.evaluate(warrantyEndDate);

  int? nextDueOdometer() {
    if (installedOdometer == null || replacementIntervalKm == null) {
      return null;
    }
    return installedOdometer! + replacementIntervalKm!;
  }

  DateTime? nextDueDate() {
    if (replacementIntervalDays == null) {
      return null;
    }
    return installedDate.add(Duration(days: replacementIntervalDays!));
  }
}

abstract final class ReplacementIntervalValidator {
  static bool isValid({int? kmInterval, int? dayInterval}) {
    if (kmInterval == null && dayInterval == null) {
      return true;
    }
    if (kmInterval != null && kmInterval <= 0) {
      return false;
    }
    if (dayInterval != null && dayInterval <= 0) {
      return false;
    }
    return true;
  }
}
