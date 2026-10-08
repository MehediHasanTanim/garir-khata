import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';

class UpdateExpense {
  const UpdateExpense({
    required this.repository,
    required this.clock,
  });

  final ExpenseRepository repository;
  final Clock clock;

  Future<Result<Expense>> call({
    required String id,
    required ExpenseInput input,
  }) async {
    final Result<Expense?> existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    if ((existing as Success<Expense?>).data == null) {
      return const Failure(
        ValidationError(message: 'Expense not found', field: 'id'),
      );
    }
    final Expense previous = existing.data!;
    if (previous.sourceType == ExpenseSourceType.fuel) {
      return const Failure(
        ValidationError(
          message: 'Linked fuel expenses are edited from the fuel entry',
          field: 'sourceType',
          code: 'expense_linked_fuel',
        ),
      );
    }

    final Result<ValidatedExpenseInput> validated =
        ExpenseValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedExpenseInput clean =
        (validated as Success<ValidatedExpenseInput>).data;
    final Expense expense = Expense(
      id: id,
      vehicleId: clean.vehicleId,
      occurredOn: clean.occurredOn,
      categoryId: clean.categoryId,
      amountPaisa: clean.amountPaisa,
      odometer: clean.odometer,
      vendorName: clean.vendorName,
      paymentMethod: clean.paymentMethod,
      description: clean.description,
      note: clean.note,
      sourceType: previous.sourceType,
      sourceRecordId: previous.sourceRecordId,
      createdAt: previous.createdAt,
      updatedAt: clock.now(),
    );
    return repository.update(expense);
  }
}
