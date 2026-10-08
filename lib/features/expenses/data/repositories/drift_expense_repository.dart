import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/data/mappers/expense_mapper.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';

class DriftExpenseRepository implements ExpenseRepository {
  DriftExpenseRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<ExpenseCategory>>> getCategories() async {
    try {
      final rows = await (_db.select(_db.expenseCategories)
            ..where((t) => t.isArchived.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();
      return Success(rows.map(ExpenseMapper.categoryToDomain).toList());
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load categories', cause: error),
      );
    }
  }

  @override
  Future<Result<ExpenseCategory?>> getCategoryByCode(String code) async {
    try {
      final row = await (_db.select(_db.expenseCategories)
            ..where((t) => t.code.equals(code)))
          .getSingleOrNull();
      return Success(row == null ? null : ExpenseMapper.categoryToDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load category', cause: error),
      );
    }
  }

  @override
  Future<Result<List<Expense>>> getHistory(
    String vehicleId, {
    DateTime? from,
    DateTime? to,
    String? categoryId,
    int limit = 100,
    int offset = 0,
  }) async {
    try {
      final query = _db.select(_db.expenses).join([
        leftOuterJoin(
          _db.expenseCategories,
          _db.expenseCategories.id.equalsExp(_db.expenses.categoryId),
        ),
      ])
        ..where(_db.expenses.vehicleId.equals(vehicleId))
        ..orderBy([OrderingTerm.desc(_db.expenses.occurredOn)])
        ..limit(limit, offset: offset);

      if (from != null) {
        query.where(_db.expenses.occurredOn.isBiggerOrEqualValue(from));
      }
      if (to != null) {
        query.where(_db.expenses.occurredOn.isSmallerThanValue(to));
      }
      if (categoryId != null) {
        query.where(_db.expenses.categoryId.equals(categoryId));
      }

      final rows = await query.get();
      return Success(
        rows.map((row) {
          final expense = row.readTable(_db.expenses);
          final category = row.readTableOrNull(_db.expenseCategories);
          return ExpenseMapper.toDomain(
            expense,
            category:
                category == null ? null : ExpenseMapper.categoryToDomain(category),
          );
        }).toList(),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load expenses', cause: error),
      );
    }
  }

  @override
  Future<Result<Expense?>> getById(String id) async {
    try {
      final query = _db.select(_db.expenses).join([
        leftOuterJoin(
          _db.expenseCategories,
          _db.expenseCategories.id.equalsExp(_db.expenses.categoryId),
        ),
      ])
        ..where(_db.expenses.id.equals(id));
      final row = await query.getSingleOrNull();
      if (row == null) {
        return const Success(null);
      }
      final category = row.readTableOrNull(_db.expenseCategories);
      return Success(
        ExpenseMapper.toDomain(
          row.readTable(_db.expenses),
          category:
              category == null ? null : ExpenseMapper.categoryToDomain(category),
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load expense', cause: error),
      );
    }
  }

  @override
  Future<Result<Expense?>> findBySource({
    required ExpenseSourceType sourceType,
    required String sourceRecordId,
  }) async {
    try {
      final row = await (_db.select(_db.expenses)
            ..where(
              (t) =>
                  t.sourceType.equals(sourceType.name) &
                  t.sourceRecordId.equals(sourceRecordId),
            ))
          .getSingleOrNull();
      return Success(row == null ? null : ExpenseMapper.toDomain(row));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to find linked expense', cause: error),
      );
    }
  }

  @override
  Future<Result<Expense>> create(Expense expense) async {
    try {
      await _db.into(_db.expenses).insert(ExpenseMapper.toCompanion(expense));
      return Success(expense);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to create expense', cause: error),
      );
    }
  }

  @override
  Future<Result<Expense>> update(Expense expense) async {
    try {
      await _db
          .into(_db.expenses)
          .insertOnConflictUpdate(ExpenseMapper.toCompanion(expense));
      return Success(expense);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to update expense', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await (_db.delete(_db.expenses)..where((t) => t.id.equals(id))).go();
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to delete expense', cause: error),
      );
    }
  }

  @override
  Future<Result<int>> sumAmountPaisa({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
    String? dashboardGroup,
  }) async {
    try {
      if (dashboardGroup == null) {
        final row = await _db
            .customSelect(
              'SELECT COALESCE(SUM(amount_paisa), 0) AS total '
              'FROM expenses WHERE vehicle_id = ? AND occurred_on >= ? AND occurred_on < ?',
              variables: [
                Variable.withString(vehicleId),
                Variable.withDateTime(from),
                Variable.withDateTime(to),
              ],
              readsFrom: {_db.expenses},
            )
            .getSingle();
        return Success(row.read<int>('total'));
      }

      final row = await _db
          .customSelect(
            'SELECT COALESCE(SUM(e.amount_paisa), 0) AS total '
            'FROM expenses e '
            'INNER JOIN expense_categories c ON c.id = e.category_id '
            'WHERE e.vehicle_id = ? AND e.occurred_on >= ? AND e.occurred_on < ? '
            'AND c.dashboard_group = ?',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
              Variable.withString(dashboardGroup),
            ],
            readsFrom: {_db.expenses, _db.expenseCategories},
          )
          .getSingle();
      return Success(row.read<int>('total'));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to sum expenses', cause: error),
      );
    }
  }
}
