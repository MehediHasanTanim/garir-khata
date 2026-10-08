import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/domain/warranty.dart';

class Tyre {
  const Tyre({
    required this.id,
    required this.vehicleId,
    required this.position,
    required this.installDate,
    required this.installOdometer,
    required this.costPaisa,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.model,
    this.size,
    this.purchaseDate,
    this.warrantyEndDate,
    this.vendorName,
    this.note,
    this.events = const [],
  });

  final String id;
  final String vehicleId;
  final TyrePosition position;
  final String? brand;
  final String? model;
  final String? size;
  final DateTime? purchaseDate;
  final DateTime installDate;
  final int installOdometer;
  final int costPaisa;
  final DateTime? warrantyEndDate;
  final String? vendorName;
  final TyreStatus status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TyreEvent> events;

  WarrantyState get warranty => WarrantyCalculator.evaluate(warrantyEndDate);

  int distanceUsed(int currentOdometer) {
    final int delta = currentOdometer - installOdometer;
    return delta < 0 ? 0 : delta;
  }

  String get displayLabel {
    final parts = <String>[
      if (brand != null && brand!.isNotEmpty) brand!,
      if (model != null && model!.isNotEmpty) model!,
      if (size != null && size!.isNotEmpty) size!,
    ];
    return parts.isEmpty ? 'Tyre' : parts.join(' ');
  }
}

class TyreEvent {
  const TyreEvent({
    required this.id,
    required this.tyreId,
    required this.vehicleId,
    required this.eventType,
    required this.occurredOn,
    required this.createdAt,
    this.odometer,
    this.fromPosition,
    this.toPosition,
    this.inspectionResult,
    this.costPaisa,
    this.note,
  });

  final String id;
  final String tyreId;
  final String vehicleId;
  final TyreEventType eventType;
  final DateTime occurredOn;
  final int? odometer;
  final TyrePosition? fromPosition;
  final TyrePosition? toPosition;
  final String? inspectionResult;
  final int? costPaisa;
  final String? note;
  final DateTime createdAt;
}
