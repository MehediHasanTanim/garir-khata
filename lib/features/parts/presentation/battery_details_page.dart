import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/battery.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:go_router/go_router.dart';

class BatteryDetailsPage extends ConsumerWidget {
  const BatteryDetailsPage({required this.batteryId, super.key});

  final String batteryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(batteryByIdProvider(batteryId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.batteryDetails)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (battery) {
          if (battery == null) {
            return Center(child: Text(l10n.commonError));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      battery.displayLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  WarrantyBadge(state: battery.warranty),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (battery.specification != null)
                _row(
                  context,
                  l10n.fieldSpecification,
                  battery.specification!,
                ),
              _row(
                context,
                l10n.fieldInstalledDate,
                MaterialLocalizations.of(context)
                    .formatMediumDate(battery.installDate),
              ),
              if (battery.purchaseDate != null)
                _row(
                  context,
                  l10n.fieldPurchaseDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(battery.purchaseDate!),
                ),
              if (battery.installOdometer != null)
                _row(
                  context,
                  l10n.fieldOdometer,
                  '${battery.installOdometer} km',
                ),
              _row(
                context,
                l10n.fieldCost,
                currency.formatPaisa(battery.costPaisa),
              ),
              if (battery.vendorName != null)
                _row(context, l10n.fieldVendor, battery.vendorName!),
              if (battery.warrantyEndDate != null)
                _row(
                  context,
                  l10n.fieldWarrantyEnd,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(battery.warrantyEndDate!),
                ),
              _row(context, l10n.fieldStatus, battery.status.name),
              if (battery.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(battery.note!),
              ],
              if (battery.status == BatteryStatus.active) ...[
                const SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: () =>
                      context.push('/batteries/add?replace=true'),
                  child: Text(l10n.replaceBattery),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: () async {
                    final Result<Battery> result = await ref
                        .read(batteryRepositoryProvider)
                        .markRemoved(battery);
                    if (!context.mounted) {
                      return;
                    }
                    if (result.isSuccess) {
                      ref.invalidate(selectedVehicleActiveBatteryProvider);
                      ref.invalidate(selectedVehicleBatteryHistoryProvider);
                      ref.invalidate(batteryByIdProvider(batteryId));
                      context.go('/batteries');
                    }
                  },
                  child: Text(l10n.markBatteryRemoved),
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
