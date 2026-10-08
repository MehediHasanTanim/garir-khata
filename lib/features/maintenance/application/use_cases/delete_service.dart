import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/service_repository.dart';

class DeleteService {
  const DeleteService({
    required this.repository,
    required this.expenseLink,
  });

  final ServiceRepository repository;
  final ServiceExpenseLink expenseLink;

  Future<Result<void>> call(String id) async {
    final Result<void> deleted = await repository.delete(id);
    if (deleted case Success()) {
      await expenseLink.deleteForSource(ExpenseSourceType.service, id);
    }
    return deleted;
  }
}
