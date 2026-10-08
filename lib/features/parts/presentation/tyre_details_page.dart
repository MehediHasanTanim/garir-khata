import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/parts/presentation/widgets/warranty_badge.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class TyreDetailsPage extends ConsumerWidget {
  const TyreDetailsPage({required this.tyreId, super.key});

  final String tyreId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final async = ref.watch(tyreByIdProvider(tyreId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tyreDetails)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (tyre) {
          if (tyre == null) {
            return Center(child: Text(l10n.commonError));
          }
          final posLabel = languageCode == 'bn'
              ? TyrePositionRules.labelBn(tyre.position)
              : TyrePositionRules.labelEn(tyre.position);
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tyre.displayLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  WarrantyBadge(state: tyre.warranty),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _row(context, l10n.tyrePosition, posLabel),
              _row(
                context,
                l10n.fieldInstalledDate,
                MaterialLocalizations.of(context)
                    .formatMediumDate(tyre.installDate),
              ),
              _row(
                context,
                l10n.fieldOdometer,
                '${tyre.installOdometer} km',
              ),
              _row(
                context,
                l10n.fieldCost,
                currency.formatPaisa(tyre.costPaisa),
              ),
              if (tyre.vendorName != null)
                _row(context, l10n.fieldVendor, tyre.vendorName!),
              if (tyre.warrantyEndDate != null)
                _row(
                  context,
                  l10n.fieldWarrantyEnd,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(tyre.warrantyEndDate!),
                ),
              if (tyre.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(tyre.note!),
              ],
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.tyreEvents,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ...tyre.events.map((e) {
                final typeLabel = switch (e.eventType) {
                  TyreEventType.installed => l10n.tyreEventInstalled,
                  TyreEventType.rotated => l10n.tyreEventRotated,
                  TyreEventType.inspected => l10n.tyreEventInspected,
                  TyreEventType.repaired => l10n.tyreEventRepaired,
                  TyreEventType.replaced => l10n.tyreEventReplaced,
                  TyreEventType.removed => l10n.tyreEventRemoved,
                };
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(typeLabel),
                  subtitle: Text(
                    [
                      MaterialLocalizations.of(context)
                          .formatMediumDate(e.occurredOn),
                      if (e.odometer != null) '${e.odometer} km',
                      if (e.note != null) e.note!,
                    ].join(' · '),
                  ),
                );
              }),
              if (tyre.status == TyreStatus.active) ...[
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    OutlinedButton(
                      onPressed: () => _addEvent(
                        context,
                        ref,
                        tyre,
                        TyreEventType.inspected,
                      ),
                      child: Text(l10n.tyreActionInspect),
                    ),
                    OutlinedButton(
                      onPressed: () => _addEvent(
                        context,
                        ref,
                        tyre,
                        TyreEventType.repaired,
                      ),
                      child: Text(l10n.tyreActionRepair),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          _rotate(context, ref, tyre, languageCode),
                      child: Text(l10n.tyreActionRotate),
                    ),
                    FilledButton(
                      onPressed: () => _replace(context, ref, tyre),
                      child: Text(l10n.tyreActionReplace),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _addEvent(
    BuildContext context,
    WidgetRef ref,
    Tyre tyre,
    TyreEventType type,
  ) async {
    final noteController = TextEditingController();
    final odoController =
        TextEditingController(text: '${tyre.installOdometer}');
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          type == TyreEventType.inspected
              ? context.l10n.tyreActionInspect
              : context.l10n.tyreActionRepair,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: odoController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration:
                  InputDecoration(labelText: context.l10n.fieldOdometer),
            ),
            TextField(
              controller: noteController,
              decoration:
                  InputDecoration(labelText: context.l10n.fieldNotesOptional),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.commonAdd),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) {
      return;
    }
    final now = ref.read(clockProvider).now();
    await ref.read(tyreRepositoryProvider).addEvent(
          TyreEvent(
            id: ref.read(uuidGeneratorProvider).v4(),
            tyreId: tyre.id,
            vehicleId: tyre.vehicleId,
            eventType: type,
            occurredOn: now,
            odometer: int.tryParse(odoController.text.trim()),
            note: noteController.text.trim().isEmpty
                ? null
                : noteController.text.trim(),
            createdAt: now,
          ),
        );
    ref.invalidate(tyreByIdProvider(tyre.id));
  }

  Future<void> _rotate(
    BuildContext context,
    WidgetRef ref,
    Tyre tyre,
    String languageCode,
  ) async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null || !context.mounted) {
      return;
    }
    final positions = TyrePositionRules.forVehicleType(vehicle.vehicleType)
        .where((p) => p != tyre.position)
        .toList();
    TyrePosition? selected = positions.firstOrNull;
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text(context.l10n.tyreActionRotate),
          content: Wrap(
            spacing: 8,
            children: positions.map((p) {
              final label = languageCode == 'bn'
                  ? TyrePositionRules.labelBn(p)
                  : TyrePositionRules.labelEn(p);
              return ChoiceChip(
                label: Text(label),
                selected: selected == p,
                onSelected: (_) => setLocal(() => selected = p),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(context.l10n.commonAdd),
            ),
          ],
        ),
      ),
    );
    if (ok != true || selected == null || !context.mounted) {
      return;
    }
    final now = ref.read(clockProvider).now();
    await ref.read(tyreRepositoryProvider).addEvent(
          TyreEvent(
            id: ref.read(uuidGeneratorProvider).v4(),
            tyreId: tyre.id,
            vehicleId: tyre.vehicleId,
            eventType: TyreEventType.rotated,
            occurredOn: now,
            fromPosition: tyre.position,
            toPosition: selected,
            createdAt: now,
          ),
        );
    await ref.read(tyreRepositoryProvider).update(
          Tyre(
            id: tyre.id,
            vehicleId: tyre.vehicleId,
            position: selected!,
            brand: tyre.brand,
            model: tyre.model,
            size: tyre.size,
            purchaseDate: tyre.purchaseDate,
            installDate: tyre.installDate,
            installOdometer: tyre.installOdometer,
            costPaisa: tyre.costPaisa,
            warrantyEndDate: tyre.warrantyEndDate,
            vendorName: tyre.vendorName,
            status: tyre.status,
            note: tyre.note,
            createdAt: tyre.createdAt,
            updatedAt: now,
          ),
        );
    ref.invalidate(tyreByIdProvider(tyre.id));
    ref.invalidate(selectedVehicleActiveTyresProvider);
  }

  Future<void> _replace(
    BuildContext context,
    WidgetRef ref,
    Tyre tyre,
  ) async {
    final brand = TextEditingController(text: tyre.brand ?? '');
    final model = TextEditingController(text: tyre.model ?? '');
    final size = TextEditingController(text: tyre.size ?? '');
    final cost = TextEditingController();
    final odo = TextEditingController(text: '${tyre.installOdometer}');
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.tyreActionReplace),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: brand,
                decoration:
                    InputDecoration(labelText: context.l10n.fieldBrand),
              ),
              TextField(
                controller: model,
                decoration:
                    InputDecoration(labelText: context.l10n.fieldModel),
              ),
              TextField(
                controller: size,
                decoration:
                    InputDecoration(labelText: context.l10n.fieldTyreSize),
              ),
              TextField(
                controller: odo,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    InputDecoration(labelText: context.l10n.fieldOdometer),
              ),
              TextField(
                controller: cost,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: context.l10n.fieldCost,
                  prefixText: '৳ ',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.commonAdd),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) {
      return;
    }
    final now = ref.read(clockProvider).now();
    final uuid = ref.read(uuidGeneratorProvider);
    final String newId = uuid.v4();
    final int installOdo =
        int.tryParse(odo.text.trim()) ?? tyre.installOdometer;
    final int costPaisa =
        MoneyPrecision.toPaisa(double.tryParse(cost.text.trim()) ?? 0);
    final Tyre newTyre = Tyre(
      id: newId,
      vehicleId: tyre.vehicleId,
      position: tyre.position,
      brand: brand.text.trim().isEmpty ? null : brand.text.trim(),
      model: model.text.trim().isEmpty ? null : model.text.trim(),
      size: size.text.trim().isEmpty ? null : size.text.trim(),
      installDate: now,
      installOdometer: installOdo,
      costPaisa: costPaisa,
      status: TyreStatus.active,
      createdAt: now,
      updatedAt: now,
    );
    final Result<Tyre> result = await ref.read(tyreRepositoryProvider).replace(
          oldTyre: tyre,
          newTyre: newTyre,
          removeEvent: TyreEvent(
            id: uuid.v4(),
            tyreId: tyre.id,
            vehicleId: tyre.vehicleId,
            eventType: TyreEventType.replaced,
            occurredOn: now,
            odometer: installOdo,
            createdAt: now,
          ),
          installEvent: TyreEvent(
            id: uuid.v4(),
            tyreId: newId,
            vehicleId: tyre.vehicleId,
            eventType: TyreEventType.installed,
            occurredOn: now,
            odometer: installOdo,
            toPosition: tyre.position,
            costPaisa: costPaisa,
            createdAt: now,
          ),
        );
    if (!context.mounted) {
      return;
    }
    if (result.isSuccess) {
      ref.invalidate(selectedVehicleActiveTyresProvider);
      context.go('/tyres/$newId');
    }
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
