import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';

class DeleteExpense {
  const DeleteExpense(this.repository);

  final ExpenseRepository repository;

  Future<Result<void>> call(String id) async {
    final Result<Expense?> existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    final Expense? expense = (existing as Success<Expense?>).data;
    if (expense == null) {
      return const Success(null);
    }
    if (expense.sourceType == ExpenseSourceType.fuel) {
      return const Failure(
        ValidationError(
          message: 'Delete the fuel entry to remove this expense',
          field: 'sourceType',
          code: 'expense_linked_fuel',
        ),
      );
    }
    return repository.delete(id);
  }
}
