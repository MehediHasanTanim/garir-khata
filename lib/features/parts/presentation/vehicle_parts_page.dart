import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:go_router/go_router.dart';

class VehiclePartsPage extends ConsumerWidget {
  const VehiclePartsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final parts = ref.watch(selectedVehiclePartsProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.vehicleParts)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/parts/add'),
        child: const Icon(Icons.add),
      ),
      body: parts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.vehiclePartsEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.vehiclePartsEmptyHint,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/parts/add'),
                      child: Text(l10n.addVehiclePart),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final VehiclePart part = items[index];
              final nextKm = part.nextDueOdometer();
              return Card(
                child: ListTile(
                  title: Text(part.name),
                  subtitle: Text(
                    [
                      if (part.brand != null) part.brand!,
                      MaterialLocalizations.of(context)
                          .formatMediumDate(part.installedDate),
                      if (nextKm != null) '${l10n.nextDue}: $nextKm km',
                    ].join(' · '),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(currency.formatPaisa(part.costPaisa)),
                      WarrantyBadge(state: part.warranty),
                    ],
                  ),
                  onTap: () => context.push('/parts/${part.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
