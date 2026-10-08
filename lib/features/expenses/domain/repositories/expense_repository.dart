import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';

abstract interface class ExpenseRepository {
  Future<Result<List<ExpenseCategory>>> getCategories();

  Future<Result<ExpenseCategory?>> getCategoryByCode(String code);

  Future<Result<List<Expense>>> getHistory(
    String vehicleId, {
    DateTime? from,
    DateTime? to,
    String? categoryId,
    int limit = 100,
    int offset = 0,
  });

  Future<Result<Expense?>> getById(String id);

  Future<Result<Expense?>> findBySource({
    required ExpenseSourceType sourceType,
    required String sourceRecordId,
  });

  Future<Result<Expense>> create(Expense expense);

  Future<Result<Expense>> update(Expense expense);

  Future<Result<void>> delete(String id);

  Future<Result<int>> sumAmountPaisa({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
    String? dashboardGroup,
  });
}
