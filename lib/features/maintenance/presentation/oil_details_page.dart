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

class OilDetailsPage extends ConsumerWidget {
  const OilDetailsPage({required this.oilId, super.key});

  final String oilId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(oilByIdProvider(oilId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.oilDetails)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (oil) {
          if (oil == null) {
            return Center(child: Text(l10n.commonError));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                oil.displayLabel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                currency.formatPaisa(oil.costPaisa),
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
                    .formatMediumDate(oil.occurredOn),
              ),
              _row(context, l10n.fieldOdometer, '${oil.odometer} km'),
              if (oil.brand != null) _row(context, l10n.fieldOilBrand, oil.brand!),
              if (oil.productName != null)
                _row(context, l10n.fieldOilProduct, oil.productName!),
              if (oil.viscosity != null)
                _row(context, l10n.fieldViscosity, oil.viscosity!),
              if (oil.quantityLiters != null)
                _row(
                  context,
                  l10n.fieldOilQuantity,
                  '${oil.quantityLiters!.toStringAsFixed(1)} L',
                ),
              _row(
                context,
                l10n.oilFilterChanged,
                oil.filterChanged ? l10n.commonYes : l10n.commonNo,
              ),
              if (oil.vendorName != null)
                _row(context, l10n.fieldWorkshop, oil.vendorName!),
              if (oil.nextDueDate != null)
                _row(
                  context,
                  l10n.fieldNextDueDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(oil.nextDueDate!),
                ),
              if (oil.nextDueOdometer != null)
                _row(
                  context,
                  l10n.fieldNextDueOdometer,
                  '${oil.nextDueOdometer} km',
                ),
              if (oil.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(oil.note!),
              ],
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.destructive,
                ),
                onPressed: () async {
                  final bool? ok = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.deleteOilTitle),
                      content: Text(l10n.deleteOilMessage),
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
                      await ref.read(deleteOilChangeProvider)(oilId);
                  if (!context.mounted) {
                    return;
                  }
                  if (result.isSuccess) {
                    ref.invalidate(selectedVehicleOilHistoryProvider);
                    ref.invalidate(selectedVehicleServiceHistoryProvider);
                    ref.invalidate(selectedVehicleExpenseHistoryProvider);
                    ref.invalidate(dashboardSummaryProvider);
                    ref.invalidate(dueServicesProvider);
                    context.go('/oil');
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
