import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/data/repair_expense_link.dart';
import 'package:garir_khata/features/parts/domain/repositories/repair_repository.dart';

class DeleteRepair {
  const DeleteRepair({
    required this.repository,
    required this.expenseLink,
  });

  final RepairRepository repository;
  final RepairExpenseLink expenseLink;

  Future<Result<void>> call(String id) async {
    final Result<void> deleted = await repository.delete(id);
    if (deleted case Success()) {
      await expenseLink.delete(id);
    }
    return deleted;
  }
}
