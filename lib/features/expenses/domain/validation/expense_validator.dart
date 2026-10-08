import 'package:garir_khata/core/domain/payment_method.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';

class ExpenseInput {
  const ExpenseInput({
    required this.vehicleId,
    required this.occurredOn,
    required this.categoryId,
    this.amountMajor,
    this.odometer,
    this.vendorName,
    this.paymentMethod,
    this.description,
    this.note,
    this.sourceType = ExpenseSourceType.manual,
    this.sourceRecordId,
  });

  final String vehicleId;
  final DateTime occurredOn;
  final String categoryId;
  final double? amountMajor;
  final int? odometer;
  final String? vendorName;
  final PaymentMethod? paymentMethod;
  final String? description;
  final String? note;
  final ExpenseSourceType sourceType;
  final String? sourceRecordId;
}

class ValidatedExpenseInput {
  const ValidatedExpenseInput({
    required this.vehicleId,
    required this.occurredOn,
    required this.categoryId,
    required this.amountPaisa,
    required this.sourceType,
    this.odometer,
    this.vendorName,
    this.paymentMethod,
    this.description,
    this.note,
    this.sourceRecordId,
  });

  final String vehicleId;
  final DateTime occurredOn;
  final String categoryId;
  final int amountPaisa;
  final int? odometer;
  final String? vendorName;
  final PaymentMethod? paymentMethod;
  final String? description;
  final String? note;
  final ExpenseSourceType sourceType;
  final String? sourceRecordId;
}

abstract final class ExpenseValidator {
  static Result<ValidatedExpenseInput> validate(ExpenseInput input) {
    if (input.vehicleId.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Vehicle is required', field: 'vehicleId'),
      );
    }
    if (input.categoryId.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Category is required', field: 'categoryId'),
      );
    }
    if (input.amountMajor == null || input.amountMajor! <= 0) {
      return const Failure(
        ValidationError(message: 'Amount must be greater than zero', field: 'amount'),
      );
    }
    if (input.odometer != null && input.odometer! < 0) {
      return const Failure(
        ValidationError(message: 'Odometer cannot be negative', field: 'odometer'),
      );
    }

    return Success(
      ValidatedExpenseInput(
        vehicleId: input.vehicleId,
        occurredOn: input.occurredOn,
        categoryId: input.categoryId,
        amountPaisa: MoneyPrecision.toPaisa(input.amountMajor!),
        odometer: input.odometer,
        vendorName: _trimOrNull(input.vendorName),
        paymentMethod: input.paymentMethod,
        description: _trimOrNull(input.description),
        note: _trimOrNull(input.note),
        sourceType: input.sourceType,
        sourceRecordId: input.sourceRecordId,
      ),
    );
  }

  static String? _trimOrNull(String? value) {
    final String? trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
