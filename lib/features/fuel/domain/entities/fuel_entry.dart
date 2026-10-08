import 'package:garir_khata/core/domain/payment_method.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

export 'package:garir_khata/core/domain/payment_method.dart';

class FuelEntry {
  const FuelEntry({
    required this.id,
    required this.vehicleId,
    required this.dateTime,
    required this.odometer,
    required this.fuelType,
    required this.quantityMl,
    required this.totalCostPaisa,
    required this.isFullTank,
    required this.createdAt,
    required this.updatedAt,
    this.pricePerUnitPaisa,
    this.vendorId,
    this.stationName,
    this.locationText,
    this.paymentMethod,
    this.note,
  });

  final String id;
  final String vehicleId;
  final DateTime dateTime;
  final int odometer;
  final FuelType fuelType;
  final int quantityMl;
  final int? pricePerUnitPaisa;
  final int totalCostPaisa;
  final bool isFullTank;
  final String? vendorId;
  final String? stationName;
  final String? locationText;
  final PaymentMethod? paymentMethod;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  double get quantityLiters => quantityMl / 1000.0;
  double get totalCostMajor => totalCostPaisa / 100.0;
  double? get pricePerLiterMajor =>
      pricePerUnitPaisa == null ? null : pricePerUnitPaisa! / 100.0;
}
