import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:go_router/go_router.dart';

class ExpenseHistoryPage extends ConsumerWidget {
  const ExpenseHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final expensesAsync = ref.watch(selectedVehicleExpenseHistoryProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.expenseHistory)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/add'),
        child: const Icon(Icons.add),
      ),
      body: expensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (expenses) {
          if (expenses.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.expenseHistoryEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.expenseHistoryEmptyHint,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/expenses/add'),
                      child: Text(l10n.addExpense),
                    ),
                  ],
                ),
              ),
            );
          }

          final int total = expenses.fold<int>(0, (s, e) => s + e.amountPaisa);

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: expenses.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Text(l10n.totalExpense),
                        const Spacer(),
                        Text(
                          currency.formatPaisa(total),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final Expense expense = expenses[index - 1];
              final String title = expense.description?.isNotEmpty == true
                  ? expense.description!
                  : expense.category?.localizedName(languageCode) ??
                      l10n.expense;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    child: const Icon(Icons.payments_outlined,
                        color: AppColors.primary),
                  ),
                  title: Text(title),
                  subtitle: Text(
                    [
                      if (expense.category != null)
                        expense.category!.localizedName(languageCode),
                      MaterialLocalizations.of(context)
                          .formatMediumDate(expense.occurredOn),
                      if (expense.odometer != null) '${expense.odometer} km',
                    ].join(' · '),
                  ),
                  trailing: Text(currency.formatPaisa(expense.amountPaisa)),
                  onTap: () => context.push('/expenses/${expense.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
