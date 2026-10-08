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
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddVehiclePartPage extends ConsumerStatefulWidget {
  const AddVehiclePartPage({super.key});

  @override
  ConsumerState<AddVehiclePartPage> createState() => _AddVehiclePartPageState();
}

class _AddVehiclePartPageState extends ConsumerState<AddVehiclePartPage> {
  final _name = TextEditingController();
  final _brand = TextEditingController();
  final _partNumber = TextEditingController();
  final _odometer = TextEditingController();
  final _cost = TextEditingController();
  final _vendor = TextEditingController();
  final _intervalKm = TextEditingController();
  final _intervalDays = TextEditingController();
  final _note = TextEditingController();

  DateTime _installed = DateTime.now();
  DateTime? _warrantyEnd;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _brand.dispose();
    _partNumber.dispose();
    _odometer.dispose();
    _cost.dispose();
    _vendor.dispose();
    _intervalKm.dispose();
    _intervalDays.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool warranty}) async {
    final DateTime initial = warranty
        ? (_warrantyEnd ?? _installed.add(const Duration(days: 365)))
        : _installed;
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
        _installed = picked;
      }
    });
  }

  Future<void> _save() async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null) {
      setState(() => _error = context.l10n.selectedVehicleNone);
      return;
    }
    if (_name.text.trim().isEmpty) {
      setState(() => _error = context.l10n.fieldPartName);
      return;
    }
    final int? kmInterval = int.tryParse(_intervalKm.text.trim());
    final int? dayInterval = int.tryParse(_intervalDays.text.trim());
    if (!ReplacementIntervalValidator.isValid(
      kmInterval: kmInterval,
      dayInterval: dayInterval,
    )) {
      setState(() => _error = context.l10n.invalidReplacementInterval);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final now = ref.read(clockProvider).now();
    final Result<VehiclePart> result =
        await ref.read(vehiclePartRepositoryProvider).create(
              VehiclePart(
                id: ref.read(uuidGeneratorProvider).v4(),
                vehicleId: vehicle.id,
                category: 'other',
                name: _name.text.trim(),
                brand: _brand.text.trim().isEmpty ? null : _brand.text.trim(),
                partNumber: _partNumber.text.trim().isEmpty
                    ? null
                    : _partNumber.text.trim(),
                installedDate: _installed,
                installedOdometer: int.tryParse(
                  _odometer.text.trim().replaceAll(',', ''),
                ),
                costPaisa: MoneyPrecision.toPaisa(
                  double.tryParse(_cost.text.trim()) ?? 0,
                ),
                vendorName:
                    _vendor.text.trim().isEmpty ? null : _vendor.text.trim(),
                warrantyEndDate: _warrantyEnd,
                replacementIntervalKm: kmInterval,
                replacementIntervalDays: dayInterval,
                note: _note.text.trim().isEmpty ? null : _note.text.trim(),
                isActive: true,
                createdAt: now,
                updatedAt: now,
              ),
            );

    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehiclePartsProvider);
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
    ref.watch(selectedVehicleProvider).whenData((vehicle) {
      if (vehicle != null && _odometer.text.isEmpty) {
        _odometer.text = '${vehicle.currentOdometer}';
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addVehiclePart)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: l10n.fieldPartName),
          ),
          TextFormField(
            controller: _brand,
            decoration: InputDecoration(labelText: l10n.fieldBrand),
          ),
          TextFormField(
            controller: _partNumber,
            decoration: InputDecoration(labelText: l10n.fieldPartNumber),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldInstalledDate),
            subtitle: Text(
              MaterialLocalizations.of(context).formatMediumDate(_installed),
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
          TextFormField(
            controller: _intervalKm,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldIntervalKm),
          ),
          TextFormField(
            controller: _intervalDays,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldIntervalDays),
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
            child: Text(_saving ? l10n.commonLoading : l10n.saveVehiclePart),
          ),
        ],
      ),
    );
  }
}
