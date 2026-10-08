import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';

class DriftFuelExpenseLinkService implements FuelExpenseLinkService {
  DriftFuelExpenseLinkService({
    required this.expenseRepository,
    required this.uuidGenerator,
    required this.clock,
  });

  final ExpenseRepository expenseRepository;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  @override
  Future<void> upsertLinkedExpense(
    ValidatedFuelInput input,
    String fuelId,
  ) async {
    final Result<ExpenseCategory?> categoryResult =
        await expenseRepository.getCategoryByCode(ExpenseCategoryCodes.fuel);
    final ExpenseCategory? category =
        categoryResult is Success<ExpenseCategory?> ? categoryResult.data : null;
    if (category == null) {
      return;
    }

    final Result<Expense?> existing = await expenseRepository.findBySource(
      sourceType: ExpenseSourceType.fuel,
      sourceRecordId: fuelId,
    );
    final Expense? linked =
        existing is Success<Expense?> ? existing.data : null;
    final DateTime now = clock.now();
    final String description = [
      if (input.stationName != null && input.stationName!.isNotEmpty)
        input.stationName!,
      '${(input.quantityMl / 1000).toStringAsFixed(1)} L',
    ].join(' · ');

    if (linked == null) {
      await expenseRepository.create(
        Expense(
          id: uuidGenerator.v4(),
          vehicleId: input.vehicleId,
          occurredOn: input.dateTime,
          categoryId: category.id,
          amountPaisa: input.totalCostPaisa,
          odometer: input.odometer,
          vendorName: input.stationName,
          paymentMethod: input.paymentMethod,
          description: description,
          note: input.note,
          sourceType: ExpenseSourceType.fuel,
          sourceRecordId: fuelId,
          createdAt: now,
          updatedAt: now,
        ),
      );
      return;
    }

    await expenseRepository.update(
      Expense(
        id: linked.id,
        vehicleId: input.vehicleId,
        occurredOn: input.dateTime,
        categoryId: category.id,
        amountPaisa: input.totalCostPaisa,
        odometer: input.odometer,
        vendorName: input.stationName,
        paymentMethod: input.paymentMethod,
        description: description,
        note: input.note,
        sourceType: ExpenseSourceType.fuel,
        sourceRecordId: fuelId,
        createdAt: linked.createdAt,
        updatedAt: now,
      ),
    );
  }

  @override
  Future<void> deleteLinkedExpense(String fuelId) async {
    final Result<Expense?> existing = await expenseRepository.findBySource(
      sourceType: ExpenseSourceType.fuel,
      sourceRecordId: fuelId,
    );
    final Expense? linked =
        existing is Success<Expense?> ? existing.data : null;
    if (linked != null) {
      await expenseRepository.delete(linked.id);
    }
  }
}
