import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/fuel/application/fuel_providers.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_labels.dart';
import 'package:go_router/go_router.dart';

class FuelDetailsPage extends ConsumerWidget {
  const FuelDetailsPage({required this.fuelId, super.key});

  final String fuelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final entryAsync = ref.watch(fuelEntryProvider(fuelId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fuelDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/fuel/$fuelId/edit'),
          ),
        ],
      ),
      body: entryAsync.when(
        data: (FuelEntry? entry) {
          if (entry == null) {
            return Center(child: Text(l10n.commonError));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Card(
                color: AppColors.primary.withValues(alpha: 0.08),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Text(
                        '৳ ${entry.totalCostMajor.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        MaterialLocalizations.of(context)
                            .formatMediumDate(entry.dateTime),
                      ),
                      if (entry.isFullTank)
                        Chip(
                          label: Text(l10n.fullTankBadge),
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.15),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      _row(l10n.fieldLiters,
                          '${entry.quantityLiters.toStringAsFixed(2)} L'),
                      _row(
                        l10n.fieldPricePerLiter,
                        entry.pricePerLiterMajor == null
                            ? '—'
                            : '৳ ${entry.pricePerLiterMajor!.toStringAsFixed(2)}',
                      ),
                      _row(l10n.fieldCurrentOdometer, '${entry.odometer} km'),
                      _row(
                        l10n.fieldFuelType,
                        fuelTypeLabel(context, entry.fuelType),
                      ),
                      if (entry.stationName != null)
                        _row(l10n.fieldStation, entry.stationName!),
                      if (entry.locationText != null)
                        _row(l10n.fieldLocation, entry.locationText!),
                      if (entry.paymentMethod != null)
                        _row(
                          l10n.fieldPayment,
                          entry.paymentMethod!.name,
                        ),
                      if (entry.note != null) _row(l10n.fieldNotesOptional, entry.note!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () async {
                  final bool? ok = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.deleteFuelTitle),
                      content: Text(l10n.deleteFuelMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(l10n.commonCancel),
                        ),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(l10n.commonDelete),
                        ),
                      ],
                    ),
                  );
                  if (ok != true) {
                    return;
                  }
                  final result =
                      await ref.read(deleteFuelEntryProvider)(fuelId);
                  if (!context.mounted) {
                    return;
                  }
                  if (result.isSuccess) {
                    ref.invalidate(selectedVehicleProvider);
                    ref.invalidate(activeVehiclesProvider);
                    context.go('/fuel');
                  }
                },
                child: Text(l10n.commonDelete),
              ),
            ],
          );
        },
        loading: () => Center(child: Text(l10n.commonLoading)),
        error: (_, _) => Center(child: Text(l10n.commonError)),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value),
        ],
      ),
    );
  }
}
