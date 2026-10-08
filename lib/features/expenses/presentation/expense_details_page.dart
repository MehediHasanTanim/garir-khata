import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:go_router/go_router.dart';

class ExpenseDetailsPage extends ConsumerWidget {
  const ExpenseDetailsPage({required this.expenseId, super.key});

  final String expenseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final expenseAsync = ref.watch(expenseByIdProvider(expenseId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.expenseDetails),
        actions: [
          expenseAsync.maybeWhen(
            data: (expense) {
              if (expense == null || expense.isLinkedFuel) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push('/expenses/$expenseId/edit'),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: expenseAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (expense) {
          if (expense == null) {
            return Center(child: Text(l10n.commonError));
          }
          final String title = expense.description?.isNotEmpty == true
              ? expense.description!
              : expense.category?.localizedName(languageCode) ?? l10n.expense;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        currency.formatPaisa(expense.amountPaisa),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _row(
                context,
                l10n.fieldDate,
                MaterialLocalizations.of(context)
                    .formatMediumDate(expense.occurredOn),
              ),
              if (expense.category != null)
                _row(
                  context,
                  l10n.expenseCategory,
                  expense.category!.localizedName(languageCode),
                ),
              if (expense.odometer != null)
                _row(context, l10n.fieldOdometer, '${expense.odometer} km'),
              if (expense.vendorName != null)
                _row(context, l10n.fieldVendor, expense.vendorName!),
              if (expense.paymentMethod != null)
                _row(
                  context,
                  l10n.fieldPayment,
                  expense.paymentMethod!.name,
                ),
              if (expense.note != null) _row(context, l10n.fieldNotes, expense.note!),
              if (expense.isLinkedFuel)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Text(
                    l10n.expenseLinkedFuelHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              if (!expense.isLinkedFuel) ...[
                OutlinedButton(
                  onPressed: () => context.push('/expenses/$expenseId/edit'),
                  child: Text(l10n.commonEdit),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.destructive,
                  ),
                  onPressed: () async {
                    final bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.deleteExpenseTitle),
                        content: Text(l10n.deleteExpenseMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(l10n.commonCancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(l10n.commonDelete),
                          ),
                        ],
                      ),
                    );
                    if (confirm != true || !context.mounted) {
                      return;
                    }
                    final Result<void> result =
                        await ref.read(deleteExpenseProvider)(expenseId);
                    if (!context.mounted) {
                      return;
                    }
                    if (result.isSuccess) {
                      ref.invalidate(selectedVehicleExpenseHistoryProvider);
                      ref.invalidate(dashboardSummaryProvider);
                      context.go('/expenses');
                    }
                  },
                  child: Text(l10n.commonDelete),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
