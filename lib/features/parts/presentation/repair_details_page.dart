import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/presentation/widgets/attachments_section.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/repair_categories.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class RepairDetailsPage extends ConsumerWidget {
  const RepairDetailsPage({required this.repairId, super.key});

  final String repairId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final async = ref.watch(repairByIdProvider(repairId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.repairDetails)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (record) {
          if (record == null) {
            return Center(child: Text(l10n.commonError));
          }
          final category =
              RepairCategories.byCode(record.category)?.localizedName(
                    languageCode,
                  ) ??
              record.category;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record.problemDescription,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  WarrantyBadge(state: record.warranty),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                currency.formatPaisa(record.totalCostPaisa),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppColors.repair),
              ),
              const SizedBox(height: AppSpacing.md),
              _row(
                context,
                l10n.fieldDate,
                MaterialLocalizations.of(context)
                    .formatMediumDate(record.repairDate),
              ),
              _row(context, l10n.fieldOdometer, '${record.odometer} km'),
              _row(context, l10n.repairCategory, category),
              if (record.diagnosis != null)
                _row(context, l10n.fieldDiagnosis, record.diagnosis!),
              if (record.workPerformed != null)
                _row(context, l10n.fieldWorkPerformed, record.workPerformed!),
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
              if (record.warrantyEndDate != null)
                _row(
                  context,
                  l10n.fieldWarrantyEnd,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(record.warrantyEndDate!),
                ),
              if (record.followUpDate != null)
                _row(
                  context,
                  l10n.fieldFollowUpDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(record.followUpDate!),
                ),
              if (record.parts.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.repairParts,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ...record.parts.map(
                  (part) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(part.partName),
                    subtitle: Text(
                      [
                        if (part.brand != null) part.brand!,
                        'x${part.quantity}',
                      ].join(' · '),
                    ),
                    trailing: Text(currency.formatPaisa(part.totalCostPaisa)),
                  ),
                ),
              ],
              if (record.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(record.note!),
              ],
              const SizedBox(height: AppSpacing.lg),
              AttachmentsSection(
                ownerType: AttachmentOwnerType.repair,
                ownerId: record.id,
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.destructive,
                ),
                onPressed: () async {
                  final bool? ok = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.deleteRepairTitle),
                      content: Text(l10n.deleteRepairMessage),
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
                      await ref.read(deleteRepairProvider)(repairId);
                  if (!context.mounted) {
                    return;
                  }
                  if (result.isSuccess) {
                    ref.invalidate(selectedVehicleRepairHistoryProvider);
                    ref.invalidate(selectedVehicleExpenseHistoryProvider);
                    ref.invalidate(dashboardSummaryProvider);
                    ref.invalidate(selectedVehicleProvider);
                    context.go('/repairs');
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
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
