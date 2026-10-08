import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/expenses/application/use_cases/add_expense.dart';
import 'package:garir_khata/features/expenses/application/use_cases/delete_expense.dart';
import 'package:garir_khata/features/expenses/application/use_cases/update_expense.dart';
import 'package:garir_khata/features/expenses/data/fuel_expense_link_service.dart';
import 'package:garir_khata/features/expenses/data/repositories/drift_expense_repository.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/domain/repositories/expense_repository.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return DriftExpenseRepository(ref.watch(appDatabaseProvider));
});

final fuelExpenseLinkServiceProvider = Provider<FuelExpenseLinkService>((ref) {
  return DriftFuelExpenseLinkService(
    expenseRepository: ref.watch(expenseRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final addExpenseProvider = Provider<AddExpense>((ref) {
  return AddExpense(
    repository: ref.watch(expenseRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final updateExpenseProvider = Provider<UpdateExpense>((ref) {
  return UpdateExpense(
    repository: ref.watch(expenseRepositoryProvider),
    clock: ref.watch(clockProvider),
  );
});

final deleteExpenseProvider = Provider<DeleteExpense>((ref) {
  return DeleteExpense(ref.watch(expenseRepositoryProvider));
});

final expenseCategoriesProvider =
    FutureProvider<List<ExpenseCategory>>((ref) async {
  final Result<List<ExpenseCategory>> result =
      await ref.watch(expenseRepositoryProvider).getCategories();
  return result.when(
    success: (categories) => categories,
    failure: (error) => throw error,
  );
});

final expenseHistoryProvider =
    FutureProvider.family<List<Expense>, String>((ref, vehicleId) async {
  final Result<List<Expense>> result =
      await ref.watch(expenseRepositoryProvider).getHistory(vehicleId);
  return result.when(
    success: (expenses) => expenses,
    failure: (error) => throw error,
  );
});

final expenseByIdProvider =
    FutureProvider.family<Expense?, String>((ref, id) async {
  final Result<Expense?> result =
      await ref.watch(expenseRepositoryProvider).getById(id);
  return result.when(
    success: (expense) => expense,
    failure: (error) => throw error,
  );
});

final selectedVehicleExpenseHistoryProvider =
    FutureProvider<List<Expense>>((ref) async {
  final vehicle = await ref.watch(selectedVehicleProvider.future);
  if (vehicle == null) {
    return const [];
  }
  return ref.watch(expenseHistoryProvider(vehicle.id).future);
});
