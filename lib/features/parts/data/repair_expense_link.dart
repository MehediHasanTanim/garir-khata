import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';

class RepairExpenseLink {
  const RepairExpenseLink({
    required this.expenseRepository,
    required this.uuidGenerator,
    required this.clock,
  });

  final ExpenseRepository expenseRepository;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<void> upsert(Repair repair) async {
    if (repair.totalCostPaisa <= 0) {
      await delete(repair.id);
      return;
    }
    final Result<ExpenseCategory?> categoryResult = await expenseRepository
        .getCategoryByCode(ExpenseCategoryCodes.repair);
    final ExpenseCategory? category =
        categoryResult is Success<ExpenseCategory?> ? categoryResult.data : null;
    if (category == null) {
      return;
    }

    final Result<Expense?> existing = await expenseRepository.findBySource(
      sourceType: ExpenseSourceType.repair,
      sourceRecordId: repair.id,
    );
    final Expense? linked =
        existing is Success<Expense?> ? existing.data : null;
    final DateTime now = clock.now();
    if (linked == null) {
      await expenseRepository.create(
        Expense(
          id: uuidGenerator.v4(),
          vehicleId: repair.vehicleId,
          occurredOn: repair.repairDate,
          categoryId: category.id,
          amountPaisa: repair.totalCostPaisa,
          odometer: repair.odometer,
          vendorName: repair.vendorName,
          description: repair.problemDescription,
          note: repair.note,
          sourceType: ExpenseSourceType.repair,
          sourceRecordId: repair.id,
          createdAt: now,
          updatedAt: now,
        ),
      );
      return;
    }
    await expenseRepository.update(
      Expense(
        id: linked.id,
        vehicleId: repair.vehicleId,
        occurredOn: repair.repairDate,
        categoryId: category.id,
        amountPaisa: repair.totalCostPaisa,
        odometer: repair.odometer,
        vendorName: repair.vendorName,
        description: repair.problemDescription,
        note: repair.note,
        sourceType: ExpenseSourceType.repair,
        sourceRecordId: repair.id,
        createdAt: linked.createdAt,
        updatedAt: now,
      ),
    );
  }

  Future<void> delete(String repairId) async {
    final Result<Expense?> existing = await expenseRepository.findBySource(
      sourceType: ExpenseSourceType.repair,
      sourceRecordId: repairId,
    );
    final Expense? linked =
        existing is Success<Expense?> ? existing.data : null;
    if (linked != null) {
      await expenseRepository.delete(linked.id);
    }
  }
}
