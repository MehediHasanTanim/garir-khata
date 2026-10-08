import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';

class ServiceItem {
  const ServiceItem({
    required this.id,
    required this.serviceRecordId,
    required this.maintenanceType,
    required this.title,
    required this.costPaisa,
    required this.quantity,
    this.templateId,
    this.note,
    this.template,
  });

  final String id;
  final String serviceRecordId;
  final String? templateId;
  final String maintenanceType;
  final String title;
  final int costPaisa;
  final double quantity;
  final String? note;
  final MaintenanceTemplate? template;

  double get costMajor => costPaisa / 100.0;
}

class ServiceRecord {
  const ServiceRecord({
    required this.id,
    required this.vehicleId,
    required this.serviceDate,
    required this.odometer,
    required this.laborCostPaisa,
    required this.partsCostPaisa,
    required this.totalCostPaisa,
    required this.createdAt,
    required this.updatedAt,
    this.vendorName,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
    this.items = const [],
  });

  final String id;
  final String vehicleId;
  final DateTime serviceDate;
  final int odometer;
  final String? vendorName;
  final int laborCostPaisa;
  final int partsCostPaisa;
  final int totalCostPaisa;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ServiceItem> items;

  double get totalCostMajor => totalCostPaisa / 100.0;

  String get primaryItemTitle {
    if (items.isEmpty) {
      return 'Service';
    }
    if (items.length == 1) {
      return items.first.title;
    }
    return '${items.first.title} + ${items.length - 1}';
  }
}

class DueServiceItem {
  const DueServiceItem({
    required this.title,
    required this.sourceType,
    required this.sourceId,
    this.nextDueDate,
    this.nextDueOdometer,
    this.remainingKm,
    this.remainingDays,
  });

  final String title;
  final String sourceType; // service | oil
  final String sourceId;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final int? remainingKm;
  final int? remainingDays;
}
