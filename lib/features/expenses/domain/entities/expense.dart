import 'package:garir_khata/core/domain/payment_method.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';

enum ExpenseSourceType { manual, fuel, service, repair, imported }

class Expense {
  const Expense({
    required this.id,
    required this.vehicleId,
    required this.occurredOn,
    required this.categoryId,
    required this.amountPaisa,
    required this.sourceType,
    required this.createdAt,
    required this.updatedAt,
    this.odometer,
    this.vendorId,
    this.vendorName,
    this.paymentMethod,
    this.description,
    this.note,
    this.sourceRecordId,
    this.category,
  });

  final String id;
  final String vehicleId;
  final DateTime occurredOn;
  final String categoryId;
  final int amountPaisa;
  final int? odometer;
  final String? vendorId;
  final String? vendorName;
  final PaymentMethod? paymentMethod;
  final String? description;
  final String? note;
  final ExpenseSourceType sourceType;
  final String? sourceRecordId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ExpenseCategory? category;

  double get amountMajor => amountPaisa / 100.0;

  bool get isLinkedFuel =>
      sourceType == ExpenseSourceType.fuel && sourceRecordId != null;
}
