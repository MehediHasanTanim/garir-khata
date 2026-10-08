import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/oil_repository.dart';

class DeleteOilChange {
  const DeleteOilChange({
    required this.repository,
    required this.expenseLink,
  });

  final OilRepository repository;
  final ServiceExpenseLink expenseLink;

  Future<Result<void>> call(String id) async {
    final Result<OilChange?> existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    final OilChange? oil = (existing as Success<OilChange?>).data;
    final Result<void> deleted = await repository.delete(id);
    if (deleted case Success()) {
      if (oil?.serviceRecordId != null) {
        await expenseLink.deleteForSource(
          ExpenseSourceType.service,
          oil!.serviceRecordId!,
        );
      } else {
        await expenseLink.deleteForSource(ExpenseSourceType.service, id);
      }
    }
    return deleted;
  }
}
