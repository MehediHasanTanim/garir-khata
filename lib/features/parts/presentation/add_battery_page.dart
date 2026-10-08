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
import 'package:garir_khata/features/parts/domain/entities/battery.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddBatteryPage extends ConsumerStatefulWidget {
  const AddBatteryPage({this.replaceExisting = false, super.key});

  final bool replaceExisting;

  @override
  ConsumerState<AddBatteryPage> createState() => _AddBatteryPageState();
}

class _AddBatteryPageState extends ConsumerState<AddBatteryPage> {
  final _brand = TextEditingController();
  final _model = TextEditingController();
  final _spec = TextEditingController();
  final _odometer = TextEditingController();
  final _cost = TextEditingController();
  final _vendor = TextEditingController();
  final _note = TextEditingController();

  DateTime _installDate = DateTime.now();
  DateTime? _purchaseDate;
  DateTime? _warrantyEnd;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _spec.dispose();
    _odometer.dispose();
    _cost.dispose();
    _vendor.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate(String kind) async {
    final DateTime initial = switch (kind) {
      'purchase' => _purchaseDate ?? _installDate,
      'warranty' =>
        _warrantyEnd ?? _installDate.add(const Duration(days: 365)),
      _ => _installDate,
    };
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
      switch (kind) {
        case 'purchase':
          _purchaseDate = picked;
        case 'warranty':
          _warrantyEnd = picked;
        default:
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

    setState(() {
      _saving = true;
      _error = null;
    });

    final now = ref.read(clockProvider).now();
    final Battery battery = Battery(
      id: ref.read(uuidGeneratorProvider).v4(),
      vehicleId: vehicle.id,
      brand: _brand.text.trim().isEmpty ? null : _brand.text.trim(),
      model: _model.text.trim().isEmpty ? null : _model.text.trim(),
      specification: _spec.text.trim().isEmpty ? null : _spec.text.trim(),
      purchaseDate: _purchaseDate,
      installDate: _installDate,
      installOdometer: int.tryParse(_odometer.text.trim().replaceAll(',', '')),
      costPaisa: MoneyPrecision.toPaisa(double.tryParse(_cost.text.trim()) ?? 0),
      warrantyEndDate: _warrantyEnd,
      vendorName: _vendor.text.trim().isEmpty ? null : _vendor.text.trim(),
      status: BatteryStatus.active,
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    final Result<Battery> result;
    if (widget.replaceExisting) {
      final existing =
          await ref.read(selectedVehicleActiveBatteryProvider.future);
      if (existing != null) {
        result = await ref.read(batteryRepositoryProvider).replace(
              oldBattery: existing,
              newBattery: battery,
            );
      } else {
        result = await ref.read(batteryRepositoryProvider).create(battery);
      }
    } else {
      result = await ref.read(batteryRepositoryProvider).create(battery);
    }

    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehicleActiveBatteryProvider);
        ref.invalidate(selectedVehicleBatteryHistoryProvider);
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
      appBar: AppBar(
        title: Text(
          widget.replaceExisting ? l10n.replaceBattery : l10n.addBattery,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          TextFormField(
            controller: _brand,
            decoration: InputDecoration(labelText: l10n.fieldBrand),
          ),
          TextFormField(
            controller: _model,
            decoration: InputDecoration(labelText: l10n.fieldModel),
          ),
          TextFormField(
            controller: _spec,
            decoration: InputDecoration(labelText: l10n.fieldSpecification),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldPurchaseDate),
            subtitle: Text(
              _purchaseDate == null
                  ? l10n.optional
                  : MaterialLocalizations.of(context)
                      .formatMediumDate(_purchaseDate!),
            ),
            onTap: () => _pickDate('purchase'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldInstalledDate),
            subtitle: Text(
              MaterialLocalizations.of(context).formatMediumDate(_installDate),
            ),
            onTap: () => _pickDate('install'),
          ),
          TextFormField(
            controller: _odometer,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldOdometerOptional),
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
            onTap: () => _pickDate('warranty'),
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
            child: Text(_saving ? l10n.commonLoading : l10n.saveBattery),
          ),
        ],
      ),
    );
  }
}
