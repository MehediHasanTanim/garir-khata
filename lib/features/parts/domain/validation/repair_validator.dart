import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';

class RepairPartInput {
  const RepairPartInput({
    required this.partName,
    this.brand,
    this.partNumber,
    this.quantity = 1,
    this.unitCostMajor,
    this.warrantyEndDate,
    this.note,
  });

  final String partName;
  final String? brand;
  final String? partNumber;
  final double quantity;
  final double? unitCostMajor;
  final DateTime? warrantyEndDate;
  final String? note;
}

class RepairInput {
  const RepairInput({
    required this.vehicleId,
    required this.repairDate,
    required this.odometer,
    required this.category,
    required this.problemDescription,
    this.diagnosis,
    this.workPerformed,
    this.vendorName,
    this.laborMajor,
    this.partsMajor,
    this.warrantyEndDate,
    this.followUpDate,
    this.note,
    this.parts = const [],
  });

  final String vehicleId;
  final DateTime repairDate;
  final int odometer;
  final String category;
  final String problemDescription;
  final String? diagnosis;
  final String? workPerformed;
  final String? vendorName;
  final double? laborMajor;
  final double? partsMajor;
  final DateTime? warrantyEndDate;
  final DateTime? followUpDate;
  final String? note;
  final List<RepairPartInput> parts;
}

class ValidatedRepairPart {
  const ValidatedRepairPart({
    required this.partName,
    required this.quantity,
    required this.unitCostPaisa,
    required this.totalCostPaisa,
    this.brand,
    this.partNumber,
    this.warrantyEndDate,
    this.note,
  });

  final String partName;
  final String? brand;
  final String? partNumber;
  final double quantity;
  final int unitCostPaisa;
  final int totalCostPaisa;
  final DateTime? warrantyEndDate;
  final String? note;
}

class ValidatedRepairInput {
  const ValidatedRepairInput({
    required this.vehicleId,
    required this.repairDate,
    required this.odometer,
    required this.category,
    required this.problemDescription,
    required this.laborCostPaisa,
    required this.partsCostPaisa,
    required this.totalCostPaisa,
    required this.parts,
    this.diagnosis,
    this.workPerformed,
    this.vendorName,
    this.warrantyEndDate,
    this.followUpDate,
    this.note,
  });

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
  final List<ValidatedRepairPart> parts;
}

abstract final class RepairValidator {
  static Result<ValidatedRepairInput> validate(RepairInput input) {
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
    if (input.category.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Category is required', field: 'category'),
      );
    }
    if (input.problemDescription.trim().isEmpty) {
      return const Failure(
        ValidationError(
          message: 'Problem description is required',
          field: 'problem',
        ),
      );
    }

    final List<ValidatedRepairPart> parts = <ValidatedRepairPart>[];
    for (final part in input.parts) {
      if (part.partName.trim().isEmpty) {
        return const Failure(
          ValidationError(message: 'Part name is required', field: 'parts'),
        );
      }
      final double qty = part.quantity <= 0 ? 1 : part.quantity;
      final int unit = MoneyPrecision.toPaisa(part.unitCostMajor ?? 0);
      parts.add(
        ValidatedRepairPart(
          partName: part.partName.trim(),
          brand: _trim(part.brand),
          partNumber: _trim(part.partNumber),
          quantity: qty,
          unitCostPaisa: unit,
          totalCostPaisa: (unit * qty).round(),
          warrantyEndDate: part.warrantyEndDate,
          note: _trim(part.note),
        ),
      );
    }

    final int labor = MoneyPrecision.toPaisa(input.laborMajor ?? 0);
    int partsCost = MoneyPrecision.toPaisa(input.partsMajor ?? 0);
    final int partsSum =
        parts.fold<int>(0, (s, p) => s + p.totalCostPaisa);
    if ((input.partsMajor == null || input.partsMajor == 0) && partsSum > 0) {
      partsCost = partsSum;
    }

    return Success(
      ValidatedRepairInput(
        vehicleId: input.vehicleId,
        repairDate: input.repairDate,
        odometer: input.odometer,
        category: input.category,
        problemDescription: input.problemDescription.trim(),
        diagnosis: _trim(input.diagnosis),
        workPerformed: _trim(input.workPerformed),
        vendorName: _trim(input.vendorName),
        laborCostPaisa: labor,
        partsCostPaisa: partsCost,
        totalCostPaisa: ServiceCostCalculator.totalPaisa(
          laborPaisa: labor,
          partsPaisa: partsCost,
        ),
        warrantyEndDate: input.warrantyEndDate,
        followUpDate: input.followUpDate,
        note: _trim(input.note),
        parts: parts,
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
