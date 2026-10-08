import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/result/result.dart';

class OilChangeInput {
  const OilChangeInput({
    required this.vehicleId,
    required this.occurredOn,
    required this.odometer,
    this.brand,
    this.productName,
    this.viscosity,
    this.quantityLiters,
    this.costMajor,
    this.filterChanged = false,
    this.vendorName,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
    this.createServiceRecord = true,
    this.createExpense = true,
  });

  final String vehicleId;
  final DateTime occurredOn;
  final int odometer;
  final String? brand;
  final String? productName;
  final String? viscosity;
  final double? quantityLiters;
  final double? costMajor;
  final bool filterChanged;
  final String? vendorName;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
  final bool createServiceRecord;
  final bool createExpense;
}

class ValidatedOilChangeInput {
  const ValidatedOilChangeInput({
    required this.vehicleId,
    required this.occurredOn,
    required this.odometer,
    required this.costPaisa,
    required this.filterChanged,
    required this.createServiceRecord,
    required this.createExpense,
    this.brand,
    this.productName,
    this.viscosity,
    this.quantityMl,
    this.vendorName,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
  });

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
  final bool createServiceRecord;
  final bool createExpense;
}

abstract final class OilValidator {
  static Result<ValidatedOilChangeInput> validate(OilChangeInput input) {
    if (input.vehicleId.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Vehicle is required', field: 'vehicleId'),
      );
    }
    if (input.odometer < 0) {
      return const Failure(
        ValidationError(message: 'Odometer cannot be negative', field: 'odometer'),
      );
    }
    if (input.costMajor != null && input.costMajor! < 0) {
      return const Failure(
        ValidationError(message: 'Cost cannot be negative', field: 'cost'),
      );
    }
    if (input.quantityLiters != null && input.quantityLiters! < 0) {
      return const Failure(
        ValidationError(
          message: 'Quantity cannot be negative',
          field: 'quantity',
        ),
      );
    }

    return Success(
      ValidatedOilChangeInput(
        vehicleId: input.vehicleId,
        occurredOn: input.occurredOn,
        odometer: input.odometer,
        brand: _trim(input.brand),
        productName: _trim(input.productName),
        viscosity: _trim(input.viscosity),
        quantityMl: input.quantityLiters == null
            ? null
            : FuelPrecision.toMilliliters(input.quantityLiters!),
        costPaisa: MoneyPrecision.toPaisa(input.costMajor ?? 0),
        filterChanged: input.filterChanged,
        vendorName: _trim(input.vendorName),
        nextDueDate: input.nextDueDate,
        nextDueOdometer: input.nextDueOdometer,
        note: _trim(input.note),
        createServiceRecord: input.createServiceRecord,
        createExpense: input.createExpense,
      ),
    );
  }

  static String? _trim(String? value) {
    final String? trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
