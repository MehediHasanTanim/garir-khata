import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddTyrePage extends ConsumerStatefulWidget {
  const AddTyrePage({this.initialPosition, super.key});

  final String? initialPosition;

  @override
  ConsumerState<AddTyrePage> createState() => _AddTyrePageState();
}

class _AddTyrePageState extends ConsumerState<AddTyrePage> {
  final _brand = TextEditingController();
  final _model = TextEditingController();
  final _size = TextEditingController();
  final _odometer = TextEditingController();
  final _cost = TextEditingController();
  final _vendor = TextEditingController();
  final _note = TextEditingController();

  DateTime _installDate = DateTime.now();
  DateTime? _warrantyEnd;
  TyrePosition? _position;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _size.dispose();
    _odometer.dispose();
    _cost.dispose();
    _vendor.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool warranty}) async {
    final DateTime initial = warranty
        ? (_warrantyEnd ?? _installDate.add(const Duration(days: 365)))
        : _installDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      if (warranty) {
        _warrantyEnd = picked;
      } else {
        _installDate = picked;
      }
    });
  }

  Future<void> _save() async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null) {
      setState(() => _error = context.l10n.selectedVehicleNone);
      return;
    }
    final TyrePosition? position = _position;
    if (position == null ||
        !TyrePositionRules.isValidFor(vehicle.vehicleType, position)) {
      setState(() => _error = context.l10n.selectTyrePosition);
      return;
    }
    final int? odo = int.tryParse(_odometer.text.trim().replaceAll(',', ''));
    if (odo == null || odo < 0) {
      setState(() => _error = context.l10n.fieldOdometer);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final now = ref.read(clockProvider).now();
    final String tyreId = ref.read(uuidGeneratorProvider).v4();
    final Tyre tyre = Tyre(
      id: tyreId,
      vehicleId: vehicle.id,
      position: position,
      brand: _brand.text.trim().isEmpty ? null : _brand.text.trim(),
      model: _model.text.trim().isEmpty ? null : _model.text.trim(),
      size: _size.text.trim().isEmpty ? null : _size.text.trim(),
      installDate: _installDate,
      installOdometer: odo,
      costPaisa: MoneyPrecision.toPaisa(double.tryParse(_cost.text.trim()) ?? 0),
      warrantyEndDate: _warrantyEnd,
      vendorName: _vendor.text.trim().isEmpty ? null : _vendor.text.trim(),
      status: TyreStatus.active,
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      createdAt: now,
      updatedAt: now,
    );
    final Result<Tyre> result =
        await ref.read(tyreRepositoryProvider).create(
              tyre,
              installEvent: TyreEvent(
                id: ref.read(uuidGeneratorProvider).v4(),
                tyreId: tyreId,
                vehicleId: vehicle.id,
                eventType: TyreEventType.installed,
                occurredOn: _installDate,
                odometer: odo,
                toPosition: position,
                costPaisa: tyre.costPaisa,
                createdAt: now,
              ),
            );

    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehicleActiveTyresProvider);
        context.pop();
      },
      failure: (error) {
        setState(() {
          _saving = false;
          _error = error.message;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final vehicleAsync = ref.watch(selectedVehicleProvider);

    vehicleAsync.whenData((vehicle) {
      if (vehicle != null && _odometer.text.isEmpty) {
        _odometer.text = '${vehicle.currentOdometer}';
      }
      if (vehicle != null && _position == null) {
        final positions =
            TyrePositionRules.forVehicleType(vehicle.vehicleType);
        TyrePosition? initial;
        if (widget.initialPosition != null) {
          for (final p in positions) {
            if (p.name == widget.initialPosition) {
              initial = p;
              break;
            }
          }
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _position == null) {
            setState(() => _position = initial ?? positions.first);
          }
        });
      }
    });

    final vehicle = vehicleAsync.value;
    final positions = vehicle == null
        ? const <TyrePosition>[]
        : TyrePositionRules.forVehicleType(vehicle.vehicleType);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addTyre)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.tyrePosition, style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: AppSpacing.xs,
            children: positions.map((p) {
              final label = languageCode == 'bn'
                  ? TyrePositionRules.labelBn(p)
                  : TyrePositionRules.labelEn(p);
              return ChoiceChip(
                label: Text(label),
                selected: _position == p,
                onSelected: (_) => setState(() => _position = p),
              );
            }).toList(),
          ),
          TextFormField(
            controller: _brand,
            decoration: InputDecoration(labelText: l10n.fieldBrand),
          ),
          TextFormField(
            controller: _model,
            decoration: InputDecoration(labelText: l10n.fieldModel),
          ),
          TextFormField(
            controller: _size,
            decoration: InputDecoration(labelText: l10n.fieldTyreSize),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldInstalledDate),
            subtitle: Text(
              MaterialLocalizations.of(context).formatMediumDate(_installDate),
            ),
            onTap: () => _pickDate(warranty: false),
          ),
          TextFormField(
            controller: _odometer,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldOdometer),
          ),
          TextFormField(
            controller: _cost,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldCost,
              prefixText: '৳ ',
            ),
          ),
          TextFormField(
            controller: _vendor,
            decoration: InputDecoration(labelText: l10n.fieldVendor),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldWarrantyEnd),
            subtitle: Text(
              _warrantyEnd == null
                  ? l10n.optional
                  : MaterialLocalizations.of(context)
                      .formatMediumDate(_warrantyEnd!),
            ),
            onTap: () => _pickDate(warranty: true),
          ),
          TextFormField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(labelText: l10n.fieldNotesOptional),
          ),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: AppColors.destructive)),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? l10n.commonLoading : l10n.saveTyre),
          ),
        ],
      ),
    );
  }
}
