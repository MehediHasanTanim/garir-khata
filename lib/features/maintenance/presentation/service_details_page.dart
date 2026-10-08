import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/maintenance/application/maintenance_providers.dart';
import 'package:go_router/go_router.dart';

class ServiceDetailsPage extends ConsumerWidget {
  const ServiceDetailsPage({required this.serviceId, super.key});

  final String serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(serviceByIdProvider(serviceId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.serviceDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/services/$serviceId/edit'),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (record) {
          if (record == null) {
            return Center(child: Text(l10n.commonError));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                record.primaryItemTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                currency.formatPaisa(record.totalCostPaisa),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.md),
              _row(
                context,
                l10n.fieldDate,
                MaterialLocalizations.of(context)
                    .formatMediumDate(record.serviceDate),
              ),
              _row(context, l10n.fieldOdometer, '${record.odometer} km'),
              if (record.vendorName != null)
                _row(context, l10n.fieldWorkshop, record.vendorName!),
              _row(
                context,
                l10n.fieldLaborCost,
                currency.formatPaisa(record.laborCostPaisa),
              ),
              _row(
                context,
                l10n.fieldPartsCost,
                currency.formatPaisa(record.partsCostPaisa),
              ),
              if (record.nextDueDate != null)
                _row(
                  context,
                  l10n.fieldNextDueDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(record.nextDueDate!),
                ),
              if (record.nextDueOdometer != null)
                _row(
                  context,
                  l10n.fieldNextDueOdometer,
                  '${record.nextDueOdometer} km',
                ),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.serviceItems, style: Theme.of(context).textTheme.titleMedium),
              ...record.items.map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.title),
                  trailing: Text(currency.formatPaisa(item.costPaisa)),
                ),
              ),
              if (record.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(record.note!),
              ],
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                onPressed: () => context.push('/services/$serviceId/edit'),
                child: Text(l10n.commonEdit),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.destructive,
                ),
                onPressed: () async {
                  final bool? ok = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.deleteServiceTitle),
                      content: Text(l10n.deleteServiceMessage),
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
                  if (ok != true || !context.mounted) {
                    return;
                  }
                  final Result<void> result =
                      await ref.read(deleteServiceProvider)(serviceId);
                  if (!context.mounted) {
                    return;
                  }
                  if (result.isSuccess) {
                    ref.invalidate(selectedVehicleServiceHistoryProvider);
                    ref.invalidate(selectedVehicleExpenseHistoryProvider);
                    ref.invalidate(dashboardSummaryProvider);
                    ref.invalidate(dueServicesProvider);
                    context.go('/services');
                  }
                },
                child: Text(l10n.commonDelete),
              ),
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
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
