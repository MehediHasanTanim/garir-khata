import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';

class ServiceItemInput {
  const ServiceItemInput({
    required this.title,
    required this.maintenanceType,
    this.templateId,
    this.costMajor,
    this.quantity = 1,
    this.note,
  });

  final String? templateId;
  final String maintenanceType;
  final String title;
  final double? costMajor;
  final double quantity;
  final String? note;
}

class ServiceInput {
  const ServiceInput({
    required this.vehicleId,
    required this.serviceDate,
    required this.odometer,
    required this.items,
    this.vendorName,
    this.laborMajor,
    this.partsMajor,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
  });

  final String vehicleId;
  final DateTime serviceDate;
  final int odometer;
  final String? vendorName;
  final List<ServiceItemInput> items;
  final double? laborMajor;
  final double? partsMajor;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
}

class ValidatedServiceItem {
  const ValidatedServiceItem({
    required this.maintenanceType,
    required this.title,
    required this.costPaisa,
    required this.quantity,
    this.templateId,
    this.note,
  });

  final String? templateId;
  final String maintenanceType;
  final String title;
  final int costPaisa;
  final double quantity;
  final String? note;
}

class ValidatedServiceInput {
  const ValidatedServiceInput({
    required this.vehicleId,
    required this.serviceDate,
    required this.odometer,
    required this.items,
    required this.laborCostPaisa,
    required this.partsCostPaisa,
    required this.totalCostPaisa,
    this.vendorName,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
  });

  final String vehicleId;
  final DateTime serviceDate;
  final int odometer;
  final String? vendorName;
  final List<ValidatedServiceItem> items;
  final int laborCostPaisa;
  final int partsCostPaisa;
  final int totalCostPaisa;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
}

abstract final class ServiceValidator {
  static Result<ValidatedServiceInput> validate(ServiceInput input) {
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
    if (input.items.isEmpty) {
      return const Failure(
        ValidationError(
          message: 'Add at least one service item',
          field: 'items',
        ),
      );
    }

    final List<ValidatedServiceItem> items = <ValidatedServiceItem>[];
    for (final ServiceItemInput item in input.items) {
      if (item.title.trim().isEmpty) {
        return const Failure(
          ValidationError(message: 'Service item title is required', field: 'items'),
        );
      }
      items.add(
        ValidatedServiceItem(
          templateId: item.templateId,
          maintenanceType: item.maintenanceType.trim().isEmpty
              ? 'custom'
              : item.maintenanceType.trim(),
          title: item.title.trim(),
          costPaisa: MoneyPrecision.toPaisa(item.costMajor ?? 0),
          quantity: item.quantity <= 0 ? 1 : item.quantity,
          note: _trim(item.note),
        ),
      );
    }

    final int labor = MoneyPrecision.toPaisa(input.laborMajor ?? 0);
    int parts = MoneyPrecision.toPaisa(input.partsMajor ?? 0);
    final int itemsTotal =
        items.fold<int>(0, (sum, i) => sum + i.costPaisa);
    if ((input.partsMajor == null || input.partsMajor == 0) && itemsTotal > 0) {
      parts = itemsTotal;
    }
    final int total = ServiceCostCalculator.totalPaisa(
      laborPaisa: labor,
      partsPaisa: parts,
    );

    return Success(
      ValidatedServiceInput(
        vehicleId: input.vehicleId,
        serviceDate: input.serviceDate,
        odometer: input.odometer,
        vendorName: _trim(input.vendorName),
        items: items,
        laborCostPaisa: labor,
        partsCostPaisa: parts,
        totalCostPaisa: total,
        nextDueDate: input.nextDueDate,
        nextDueOdometer: input.nextDueOdometer,
        note: _trim(input.note),
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
