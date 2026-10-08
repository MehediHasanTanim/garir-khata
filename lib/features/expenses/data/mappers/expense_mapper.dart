import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/domain/payment_method.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';

abstract final class ExpenseMapper {
  static ExpenseCategory categoryToDomain(ExpenseCategoryRow row) {
    return ExpenseCategory(
      id: row.id,
      code: row.code,
      nameEn: row.nameEn,
      nameBn: row.nameBn,
      dashboardGroup: row.dashboardGroup,
      iconKey: row.iconKey,
      isSystem: row.isSystem,
      sortOrder: row.sortOrder,
      isArchived: row.isArchived,
      createdAt: row.createdAt,
    );
  }

  static Expense toDomain(ExpenseRow row, {ExpenseCategory? category}) {
    return Expense(
      id: row.id,
      vehicleId: row.vehicleId,
      occurredOn: row.occurredOn,
      categoryId: row.categoryId,
      amountPaisa: row.amountPaisa,
      odometer: row.odometer,
      vendorId: row.vendorId,
      vendorName: row.vendorName,
      paymentMethod: row.paymentMethod == null
          ? null
          : PaymentMethod.values.byName(row.paymentMethod!),
      description: row.description,
      note: row.note,
      sourceType: _parseSource(row.sourceType),
      sourceRecordId: row.sourceRecordId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      category: category,
    );
  }

  static ExpensesCompanion toCompanion(Expense expense) {
    return ExpensesCompanion.insert(
      id: expense.id,
      vehicleId: expense.vehicleId,
      occurredOn: expense.occurredOn,
      categoryId: expense.categoryId,
      amountPaisa: expense.amountPaisa,
      odometer: Value(expense.odometer),
      vendorId: Value(expense.vendorId),
      vendorName: Value(expense.vendorName),
      paymentMethod: Value(expense.paymentMethod?.name),
      description: Value(expense.description),
      note: Value(expense.note),
      sourceType: Value(expense.sourceType.name),
      sourceRecordId: Value(expense.sourceRecordId),
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
    );
  }

  static ExpenseSourceType _parseSource(String value) {
    return ExpenseSourceType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ExpenseSourceType.manual,
    );
  }
}
