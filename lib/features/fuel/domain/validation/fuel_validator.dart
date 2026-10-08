import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_calculator.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class FuelInput {
  const FuelInput({
    required this.vehicleId,
    required this.dateTime,
    required this.odometer,
    required this.fuelType,
    required this.isFullTank,
    this.liters,
    this.pricePerLiter,
    this.totalMajor,
    this.stationName,
    this.locationText,
    this.paymentMethod,
    this.note,
  });

  final String vehicleId;
  final DateTime dateTime;
  final int odometer;
  final FuelType fuelType;
  final bool isFullTank;
  final double? liters;
  final double? pricePerLiter;
  final double? totalMajor;
  final String? stationName;
  final String? locationText;
  final PaymentMethod? paymentMethod;
  final String? note;
}

class ValidatedFuelInput {
  const ValidatedFuelInput({
    required this.vehicleId,
    required this.dateTime,
    required this.odometer,
    required this.fuelType,
    required this.isFullTank,
    required this.quantityMl,
    required this.totalCostPaisa,
    this.pricePerUnitPaisa,
    this.stationName,
    this.locationText,
    this.paymentMethod,
    this.note,
  });

  final String vehicleId;
  final DateTime dateTime;
  final int odometer;
  final FuelType fuelType;
  final bool isFullTank;
  final int quantityMl;
  final int totalCostPaisa;
  final int? pricePerUnitPaisa;
  final String? stationName;
  final String? locationText;
  final PaymentMethod? paymentMethod;
  final String? note;
}

abstract final class FuelValidator {
  static Result<ValidatedFuelInput> validate(FuelInput input) {
    if (input.vehicleId.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Vehicle is required', field: 'vehicleId'),
      );
    }
    if (input.odometer < 0) {
      return const Failure(
        ValidationError(
          message: 'Odometer must be zero or greater',
          field: 'odometer',
        ),
      );
    }
    final FuelCalculation? calc = FuelCalculator.calculate(
      liters: input.liters,
      pricePerLiter: input.pricePerLiter,
      totalMajor: input.totalMajor,
    );
    if (calc == null) {
      return const Failure(
        ValidationError(
          message: 'Enter liters and either total amount or price per liter',
          field: 'quantity',
        ),
      );
    }
    if (calc.totalCostPaisa < 0) {
      return const Failure(
        ValidationError(
          message: 'Total cost cannot be negative',
          field: 'totalCost',
        ),
      );
    }

    return Success(
      ValidatedFuelInput(
        vehicleId: input.vehicleId,
        dateTime: input.dateTime,
        odometer: input.odometer,
        fuelType: input.fuelType,
        isFullTank: input.isFullTank,
        quantityMl: calc.quantityMl,
        totalCostPaisa: calc.totalCostPaisa,
        pricePerUnitPaisa: calc.pricePerUnitPaisa,
        stationName: _emptyToNull(input.stationName),
        locationText: _emptyToNull(input.locationText),
        paymentMethod: input.paymentMethod,
        note: _emptyToNull(input.note),
      ),
    );
  }

  static String? _emptyToNull(String? value) {
    final String? trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
