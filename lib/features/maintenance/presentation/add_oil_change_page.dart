import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/maintenance/application/maintenance_providers.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/validation/oil_validator.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddOilChangePage extends ConsumerStatefulWidget {
  const AddOilChangePage({super.key});

  @override
  ConsumerState<AddOilChangePage> createState() => _AddOilChangePageState();
}

class _AddOilChangePageState extends ConsumerState<AddOilChangePage> {
  final _odometer = TextEditingController();
  final _brand = TextEditingController();
  final _product = TextEditingController();
  final _viscosity = TextEditingController(text: '10W-40');
  final _quantity = TextEditingController();
  final _cost = TextEditingController();
  final _vendor = TextEditingController();
  final _nextOdo = TextEditingController();
  final _note = TextEditingController();

  DateTime _date = DateTime.now();
  DateTime? _nextDueDate;
  bool _filterChanged = true;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _odometer.dispose();
    _brand.dispose();
    _product.dispose();
    _viscosity.dispose();
    _quantity.dispose();
    _cost.dispose();
    _vendor.dispose();
    _nextOdo.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool nextDue}) async {
    final DateTime initial = nextDue
        ? (_nextDueDate ?? _date.add(const Duration(days: 90)))
        : _date;
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
      if (nextDue) {
        _nextDueDate = picked;
      } else {
        _date = picked;
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

    final Result<OilChange> result = await ref.read(recordOilChangeProvider)(
      input: OilChangeInput(
        vehicleId: vehicle.id,
        occurredOn: _date,
        odometer: int.tryParse(_odometer.text.trim().replaceAll(',', '')) ?? -1,
        brand: _brand.text,
        productName: _product.text,
        viscosity: _viscosity.text,
        quantityLiters: double.tryParse(_quantity.text.trim()),
        costMajor: double.tryParse(_cost.text.trim()),
        filterChanged: _filterChanged,
        vendorName: _vendor.text,
        nextDueDate: _nextDueDate,
        nextDueOdometer: int.tryParse(_nextOdo.text.trim().replaceAll(',', '')),
        note: _note.text,
      ),
      vehicleType: vehicle.vehicleType,
    );

    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehicleOilHistoryProvider);
        ref.invalidate(selectedVehicleServiceHistoryProvider);
        ref.invalidate(selectedVehicleExpenseHistoryProvider);
        ref.invalidate(selectedVehicleProvider);
        ref.invalidate(dashboardSummaryProvider);
        ref.invalidate(dueServicesProvider);
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
    final vehicleAsync = ref.watch(selectedVehicleProvider);

    vehicleAsync.whenData((vehicle) {
      if (vehicle != null && _odometer.text.isEmpty) {
        _odometer.text = '${vehicle.currentOdometer}';
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addOilChange)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldDate),
            subtitle: Text(
              MaterialLocalizations.of(context).formatMediumDate(_date),
            ),
            trailing: const Icon(Icons.calendar_today_outlined),
            onTap: () => _pickDate(nextDue: false),
          ),
          TextFormField(
            controller: _odometer,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldOdometer),
          ),
          TextFormField(
            controller: _brand,
            decoration: InputDecoration(labelText: l10n.fieldOilBrand),
          ),
          TextFormField(
            controller: _product,
            decoration: InputDecoration(labelText: l10n.fieldOilProduct),
          ),
          TextFormField(
            controller: _viscosity,
            decoration: InputDecoration(labelText: l10n.fieldViscosity),
          ),
          TextFormField(
            controller: _quantity,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.fieldOilQuantity),
          ),
          TextFormField(
            controller: _cost,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldAmount,
              prefixText: '৳ ',
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.oilFilterChanged),
            value: _filterChanged,
            onChanged: (value) => setState(() => _filterChanged = value),
          ),
          TextFormField(
            controller: _vendor,
            decoration: InputDecoration(labelText: l10n.fieldWorkshop),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldNextDueDate),
            subtitle: Text(
              _nextDueDate == null
                  ? l10n.autoSuggestHint
                  : MaterialLocalizations.of(context)
                      .formatMediumDate(_nextDueDate!),
            ),
            trailing: const Icon(Icons.event_outlined),
            onTap: () => _pickDate(nextDue: true),
          ),
          TextFormField(
            controller: _nextOdo,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: l10n.fieldNextDueOdometer,
              hintText: l10n.autoSuggestHint,
            ),
          ),
          TextFormField(
            controller: _note,
            maxLines: 3,
            decoration: InputDecoration(labelText: l10n.fieldNotesOptional),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                _error!,
                style: const TextStyle(color: AppColors.destructive),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? l10n.commonLoading : l10n.saveOilChange),
          ),
        ],
      ),
    );
  }
}
