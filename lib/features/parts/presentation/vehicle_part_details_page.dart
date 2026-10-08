import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:go_router/go_router.dart';

class VehiclePartDetailsPage extends ConsumerWidget {
  const VehiclePartDetailsPage({required this.partId, super.key});

  final String partId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(vehiclePartByIdProvider(partId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.vehiclePartDetails)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (part) {
          if (part == null) {
            return Center(child: Text(l10n.commonError));
          }
          final nextKm = part.nextDueOdometer();
          final nextDate = part.nextDueDate();
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      part.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  WarrantyBadge(state: part.warranty),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(currency.formatPaisa(part.costPaisa)),
              const SizedBox(height: AppSpacing.md),
              if (part.brand != null) _row(context, l10n.fieldBrand, part.brand!),
              if (part.partNumber != null)
                _row(context, l10n.fieldPartNumber, part.partNumber!),
              _row(
                context,
                l10n.fieldInstalledDate,
                MaterialLocalizations.of(context)
                    .formatMediumDate(part.installedDate),
              ),
              if (part.installedOdometer != null)
                _row(
                  context,
                  l10n.fieldOdometer,
                  '${part.installedOdometer} km',
                ),
              if (part.vendorName != null)
                _row(context, l10n.fieldVendor, part.vendorName!),
              if (part.warrantyEndDate != null)
                _row(
                  context,
                  l10n.fieldWarrantyEnd,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(part.warrantyEndDate!),
                ),
              if (nextKm != null)
                _row(context, l10n.fieldNextDueOdometer, '$nextKm km'),
              if (nextDate != null)
                _row(
                  context,
                  l10n.fieldNextDueDate,
                  MaterialLocalizations.of(context).formatMediumDate(nextDate),
                ),
              if (part.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(part.note!),
              ],
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.destructive,
                ),
                onPressed: () async {
                  final Result<void> result = await ref
                      .read(vehiclePartRepositoryProvider)
                      .delete(partId);
                  if (!context.mounted) {
                    return;
                  }
                  if (result.isSuccess) {
                    ref.invalidate(selectedVehiclePartsProvider);
                    context.go('/parts');
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
