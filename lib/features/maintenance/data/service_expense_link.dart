import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';

class ServiceExpenseLink {
  const ServiceExpenseLink({
    required this.expenseRepository,
    required this.uuidGenerator,
    required this.clock,
  });

  final ExpenseRepository expenseRepository;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<void> upsertForService(ServiceRecord record) async {
    if (record.totalCostPaisa <= 0) {
      await deleteForSource(ExpenseSourceType.service, record.id);
      return;
    }
    final category = await _category(ExpenseCategoryCodes.maintenance);
    if (category == null) {
      return;
    }
    await _upsert(
      sourceType: ExpenseSourceType.service,
      sourceRecordId: record.id,
      vehicleId: record.vehicleId,
      occurredOn: record.serviceDate,
      categoryId: category.id,
      amountPaisa: record.totalCostPaisa,
      odometer: record.odometer,
      vendorName: record.vendorName,
      description: record.primaryItemTitle,
      note: record.note,
    );
  }

  Future<void> upsertForOil(OilChange oil) async {
    final String sourceId = oil.serviceRecordId ?? oil.id;
    if (oil.costPaisa <= 0) {
      await deleteForSource(ExpenseSourceType.service, sourceId);
      return;
    }
    final category = await _category(ExpenseCategoryCodes.engineOil) ??
        await _category(ExpenseCategoryCodes.maintenance);
    if (category == null) {
      return;
    }
    await _upsert(
      sourceType: ExpenseSourceType.service,
      sourceRecordId: sourceId,
      vehicleId: oil.vehicleId,
      occurredOn: oil.occurredOn,
      categoryId: category.id,
      amountPaisa: oil.costPaisa,
      odometer: oil.odometer,
      vendorName: oil.vendorName,
      description: oil.displayLabel,
      note: oil.note,
    );
  }

  Future<void> deleteForSource(
    ExpenseSourceType sourceType,
    String sourceRecordId,
  ) async {
    final Result<Expense?> existing = await expenseRepository.findBySource(
      sourceType: sourceType,
      sourceRecordId: sourceRecordId,
    );
    final Expense? linked =
        existing is Success<Expense?> ? existing.data : null;
    if (linked != null) {
      await expenseRepository.delete(linked.id);
    }
  }

  Future<ExpenseCategory?> _category(String code) async {
    final Result<ExpenseCategory?> result =
        await expenseRepository.getCategoryByCode(code);
    return result is Success<ExpenseCategory?> ? result.data : null;
  }

  Future<void> _upsert({
    required ExpenseSourceType sourceType,
    required String sourceRecordId,
    required String vehicleId,
    required DateTime occurredOn,
    required String categoryId,
    required int amountPaisa,
    required int odometer,
    String? vendorName,
    String? description,
    String? note,
  }) async {
    final Result<Expense?> existing = await expenseRepository.findBySource(
      sourceType: sourceType,
      sourceRecordId: sourceRecordId,
    );
    final Expense? linked =
        existing is Success<Expense?> ? existing.data : null;
    final DateTime now = clock.now();
    if (linked == null) {
      await expenseRepository.create(
        Expense(
          id: uuidGenerator.v4(),
          vehicleId: vehicleId,
          occurredOn: occurredOn,
          categoryId: categoryId,
          amountPaisa: amountPaisa,
          odometer: odometer,
          vendorName: vendorName,
          description: description,
          note: note,
          sourceType: sourceType,
          sourceRecordId: sourceRecordId,
          createdAt: now,
          updatedAt: now,
        ),
      );
      return;
    }
    await expenseRepository.update(
      Expense(
        id: linked.id,
        vehicleId: vehicleId,
        occurredOn: occurredOn,
        categoryId: categoryId,
        amountPaisa: amountPaisa,
        odometer: odometer,
        vendorName: vendorName,
        description: description,
        note: note,
        sourceType: sourceType,
        sourceRecordId: sourceRecordId,
        createdAt: linked.createdAt,
        updatedAt: now,
      ),
    );
  }
}
