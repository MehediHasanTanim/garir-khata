import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/parts/application/parts_providers.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';
import 'package:garir_khata/features/parts/domain/repair_categories.dart';
import 'package:garir_khata/features/parts/domain/validation/repair_validator.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class _DraftPart {
  _DraftPart({required this.name, this.unitCost, this.quantity = 1});
  final String name;
  double quantity;
  double? unitCost;
}

class AddRepairPage extends ConsumerStatefulWidget {
  const AddRepairPage({super.key});

  @override
  ConsumerState<AddRepairPage> createState() => _AddRepairPageState();
}

class _AddRepairPageState extends ConsumerState<AddRepairPage> {
  final _odometer = TextEditingController();
  final _problem = TextEditingController();
  final _diagnosis = TextEditingController();
  final _work = TextEditingController();
  final _vendor = TextEditingController();
  final _labor = TextEditingController();
  final _parts = TextEditingController();
  final _note = TextEditingController();

  DateTime _date = DateTime.now();
  DateTime? _warrantyEnd;
  DateTime? _followUp;
  String _category = RepairCategories.all.first.code;
  final List<_DraftPart> _draftParts = <_DraftPart>[];
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _odometer.dispose();
    _problem.dispose();
    _diagnosis.dispose();
    _work.dispose();
    _vendor.dispose();
    _labor.dispose();
    _parts.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required String kind}) async {
    final DateTime initial = switch (kind) {
      'warranty' => _warrantyEnd ?? _date.add(const Duration(days: 90)),
      'followUp' => _followUp ?? _date.add(const Duration(days: 14)),
      _ => _date,
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
        case 'warranty':
          _warrantyEnd = picked;
        case 'followUp':
          _followUp = picked;
        default:
          _date = picked;
      }
    });
  }

  Future<void> _addPart() async {
    final nameController = TextEditingController();
    final costController = TextEditingController();
    final qtyController = TextEditingController(text: '1');
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.addRepairPart),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: context.l10n.fieldPartName),
            ),
            TextField(
              controller: qtyController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: context.l10n.fieldQuantity),
            ),
            TextField(
              controller: costController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: context.l10n.fieldUnitCost,
                prefixText: '৳ ',
              ),
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
    if (ok == true && nameController.text.trim().isNotEmpty) {
      setState(() {
        _draftParts.add(
          _DraftPart(
            name: nameController.text.trim(),
            quantity: double.tryParse(qtyController.text) ?? 1,
            unitCost: double.tryParse(costController.text),
          ),
        );
      });
    }
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
    final Result<Repair> result = await ref.read(addRepairProvider)(
      RepairInput(
        vehicleId: vehicle.id,
        repairDate: _date,
        odometer: int.tryParse(_odometer.text.trim().replaceAll(',', '')) ?? -1,
        category: _category,
        problemDescription: _problem.text,
        diagnosis: _diagnosis.text,
        workPerformed: _work.text,
        vendorName: _vendor.text,
        laborMajor: double.tryParse(_labor.text.trim()),
        partsMajor: double.tryParse(_parts.text.trim()),
        warrantyEndDate: _warrantyEnd,
        followUpDate: _followUp,
        note: _note.text,
        parts: _draftParts
            .map(
              (p) => RepairPartInput(
                partName: p.name,
                quantity: p.quantity,
                unitCostMajor: p.unitCost,
              ),
            )
            .toList(),
      ),
    );
    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehicleRepairHistoryProvider);
        ref.invalidate(selectedVehicleExpenseHistoryProvider);
        ref.invalidate(selectedVehicleProvider);
        ref.invalidate(dashboardSummaryProvider);
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
    ref.watch(selectedVehicleProvider).whenData((vehicle) {
      if (vehicle != null && _odometer.text.isEmpty) {
        _odometer.text = '${vehicle.currentOdometer}';
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addRepair)),
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
            onTap: () => _pickDate(kind: 'date'),
          ),
          TextFormField(
            controller: _odometer,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldOdometer),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.repairCategory, style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: AppSpacing.xs,
            children: RepairCategories.all.map((c) {
              final selected = c.code == _category;
              return ChoiceChip(
                label: Text(c.localizedName(languageCode)),
                selected: selected,
                onSelected: (_) => setState(() => _category = c.code),
              );
            }).toList(),
          ),
          TextFormField(
            controller: _problem,
            decoration: InputDecoration(labelText: l10n.fieldProblem),
          ),
          TextFormField(
            controller: _diagnosis,
            decoration: InputDecoration(labelText: l10n.fieldDiagnosis),
          ),
          TextFormField(
            controller: _work,
            decoration: InputDecoration(labelText: l10n.fieldWorkPerformed),
          ),
          TextFormField(
            controller: _vendor,
            decoration: InputDecoration(labelText: l10n.fieldWorkshop),
          ),
          TextFormField(
            controller: _labor,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldLaborCost,
              prefixText: '৳ ',
            ),
          ),
          TextFormField(
            controller: _parts,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldPartsCost,
              prefixText: '৳ ',
            ),
          ),
          Row(
            children: [
              Text(l10n.repairParts, style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              TextButton.icon(
                onPressed: _addPart,
                icon: const Icon(Icons.add),
                label: Text(l10n.commonAdd),
              ),
            ],
          ),
          ..._draftParts.map(
            (p) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(p.name),
              subtitle: Text(
                'x${p.quantity} · ৳${(p.unitCost ?? 0).toStringAsFixed(0)}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _draftParts.remove(p)),
              ),
            ),
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
            onTap: () => _pickDate(kind: 'warranty'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldFollowUpDate),
            subtitle: Text(
              _followUp == null
                  ? l10n.optional
                  : MaterialLocalizations.of(context)
                      .formatMediumDate(_followUp!),
            ),
            onTap: () => _pickDate(kind: 'followUp'),
          ),
          TextFormField(
            controller: _note,
            maxLines: 3,
            decoration: InputDecoration(labelText: l10n.fieldNotesOptional),
          ),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: AppColors.destructive)),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? l10n.commonLoading : l10n.saveRepair),
          ),
        ],
      ),
    );
  }
}
