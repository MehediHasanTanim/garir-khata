import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/maintenance/application/maintenance_providers.dart';
import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';
import 'package:garir_khata/features/maintenance/domain/validation/service_validator.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class _DraftItem {
  _DraftItem({
    required this.title,
    required this.maintenanceType,
    this.templateId,
    this.costMajor,
  });

  final String? templateId;
  final String maintenanceType;
  final String title;
  double? costMajor;
}

class AddEditServicePage extends ConsumerStatefulWidget {
  const AddEditServicePage({this.serviceId, super.key});

  final String? serviceId;
  bool get isEditing => serviceId != null;

  @override
  ConsumerState<AddEditServicePage> createState() => _AddEditServicePageState();
}

class _AddEditServicePageState extends ConsumerState<AddEditServicePage> {
  final _odometer = TextEditingController();
  final _vendor = TextEditingController();
  final _labor = TextEditingController();
  final _parts = TextEditingController();
  final _nextOdo = TextEditingController();
  final _note = TextEditingController();

  DateTime _date = DateTime.now();
  DateTime? _nextDueDate;
  final List<_DraftItem> _items = <_DraftItem>[];
  bool _saving = false;
  bool _hydrated = false;
  String? _error;

  @override
  void dispose() {
    _odometer.dispose();
    _vendor.dispose();
    _labor.dispose();
    _parts.dispose();
    _nextOdo.dispose();
    _note.dispose();
    super.dispose();
  }

  void _hydrate(ServiceRecord record) {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _date = record.serviceDate;
    _odometer.text = '${record.odometer}';
    _vendor.text = record.vendorName ?? '';
    _labor.text = MoneyPrecision.fromPaisa(record.laborCostPaisa).toStringAsFixed(
      record.laborCostPaisa % 100 == 0 ? 0 : 2,
    );
    _parts.text = MoneyPrecision.fromPaisa(record.partsCostPaisa).toStringAsFixed(
      record.partsCostPaisa % 100 == 0 ? 0 : 2,
    );
    _nextDueDate = record.nextDueDate;
    if (record.nextDueOdometer != null) {
      _nextOdo.text = '${record.nextDueOdometer}';
    }
    _note.text = record.note ?? '';
    _items
      ..clear()
      ..addAll(
        record.items.map(
          (i) => _DraftItem(
            templateId: i.templateId,
            maintenanceType: i.maintenanceType,
            title: i.title,
            costMajor: i.costMajor,
          ),
        ),
      );
    setState(() {});
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

  Future<void> _addItem() async {
    final templates = await ref.read(maintenanceTemplatesProvider.future);
    if (!mounted) {
      return;
    }
    final languageCode = Localizations.localeOf(context).languageCode;
    final MaintenanceTemplate? selected =
        await showModalBottomSheet<MaintenanceTemplate>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    context.l10n.addServiceItem,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      final template = templates[index];
                      return ListTile(
                        title: Text(template.localizedName(languageCode)),
                        subtitle: Text(
                          [
                            if (template.defaultKmInterval != null)
                              '${template.defaultKmInterval} km',
                            if (template.defaultDayInterval != null)
                              '${template.defaultDayInterval} days',
                          ].join(' · '),
                        ),
                        trailing: const Icon(Icons.add),
                        onTap: () => Navigator.pop(context, template),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (selected == null) {
      return;
    }
    setState(() {
      _items.add(
        _DraftItem(
          templateId: selected.id,
          maintenanceType: selected.code,
          title: selected.nameEn,
        ),
      );
      if (_nextDueDate == null && _nextOdo.text.isEmpty) {
        final suggestion = NextDueCalculator.suggest(
          performedOdometer: int.tryParse(_odometer.text) ?? 0,
          performedAt: _date,
          kmInterval: selected.defaultKmInterval,
          dayInterval: selected.defaultDayInterval,
        );
        _nextDueDate = suggestion.nextDueDate;
        if (suggestion.nextDueOdometer != null) {
          _nextOdo.text = '${suggestion.nextDueOdometer}';
        }
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

    final input = ServiceInput(
      vehicleId: vehicle.id,
      serviceDate: _date,
      odometer: int.tryParse(_odometer.text.trim().replaceAll(',', '')) ?? -1,
      vendorName: _vendor.text,
      laborMajor: double.tryParse(_labor.text.trim()),
      partsMajor: double.tryParse(_parts.text.trim()),
      nextDueDate: _nextDueDate,
      nextDueOdometer: int.tryParse(_nextOdo.text.trim().replaceAll(',', '')),
      note: _note.text,
      items: _items
          .map(
            (i) => ServiceItemInput(
              templateId: i.templateId,
              maintenanceType: i.maintenanceType,
              title: i.title,
              costMajor: i.costMajor,
            ),
          )
          .toList(),
    );

    final Result<ServiceRecord> result;
    if (widget.isEditing) {
      result = await ref.read(updateServiceProvider)(
        id: widget.serviceId!,
        input: input,
      );
    } else {
      result = await ref.read(addServiceProvider)(input);
    }

    if (!mounted) {
      return;
    }
    if (result.isSuccess) {
      ref.invalidate(selectedVehicleServiceHistoryProvider);
      ref.invalidate(selectedVehicleExpenseHistoryProvider);
      ref.invalidate(selectedVehicleProvider);
      ref.invalidate(dashboardSummaryProvider);
      ref.invalidate(dueServicesProvider);
      await ref.read(reminderEngineProvider).evaluateForVehicle(vehicle.id);
      ref.invalidate(upcomingDashboardRemindersProvider);
      if (mounted) {
        context.pop();
      }
      return;
    }
    setState(() {
      _saving = false;
      _error = result.errorOrNull?.message ?? context.l10n.commonError;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (widget.isEditing) {
      ref.watch(serviceByIdProvider(widget.serviceId!)).whenData((record) {
        if (record != null) {
          _hydrate(record);
        }
      });
    }

    final double labor = double.tryParse(_labor.text) ?? 0;
    final double parts = double.tryParse(_parts.text) ?? 0;
    final double itemsCost =
        _items.fold<double>(0, (s, i) => s + (i.costMajor ?? 0));
    final double total =
        labor + (parts > 0 ? parts : itemsCost);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editService : l10n.addService),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          if (widget.isEditing)
            Card(
              color: AppColors.warning.withValues(alpha: 0.15),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(l10n.serviceCostUpdateWarning),
              ),
            ),
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
            controller: _vendor,
            decoration: InputDecoration(labelText: l10n.fieldWorkshop),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(l10n.serviceItems, style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              TextButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: Text(l10n.commonAdd),
              ),
            ],
          ),
          if (_items.isEmpty)
            Text(l10n.serviceItemsEmpty)
          else
            ..._items.asMap().entries.map((entry) {
              final int index = entry.key;
              final item = entry.value;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.title),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _items.removeAt(index)),
                ),
              );
            }),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _labor,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldLaborCost,
              prefixText: '৳ ',
            ),
            onChanged: (_) => setState(() {}),
          ),
          TextFormField(
            controller: _parts,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldPartsCost,
              prefixText: '৳ ',
            ),
            onChanged: (_) => setState(() {}),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldTotalCost),
            trailing: Text('৳ ${total.toStringAsFixed(0)}'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldNextDueDate),
            subtitle: Text(
              _nextDueDate == null
                  ? l10n.optional
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
            decoration: InputDecoration(labelText: l10n.fieldNextDueOdometer),
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
            child: Text(_saving ? l10n.commonLoading : l10n.saveService),
          ),
        ],
      ),
    );
  }
}
