import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';

class AddExpense {
  const AddExpense({
    required this.repository,
    required this.uuidGenerator,
    required this.clock,
  });

  final ExpenseRepository repository;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<Expense>> call(ExpenseInput input) async {
    final Result<ValidatedExpenseInput> validated =
        ExpenseValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedExpenseInput clean =
        (validated as Success<ValidatedExpenseInput>).data;
    final DateTime now = clock.now();
    final Expense expense = Expense(
      id: uuidGenerator.v4(),
      vehicleId: clean.vehicleId,
      occurredOn: clean.occurredOn,
      categoryId: clean.categoryId,
      amountPaisa: clean.amountPaisa,
      odometer: clean.odometer,
      vendorName: clean.vendorName,
      paymentMethod: clean.paymentMethod,
      description: clean.description,
      note: clean.note,
      sourceType: clean.sourceType,
      sourceRecordId: clean.sourceRecordId,
      createdAt: now,
      updatedAt: now,
    );
    return repository.create(expense);
  }
}
