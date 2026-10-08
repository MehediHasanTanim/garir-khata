import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/fuel/application/fuel_providers.dart';
import 'package:garir_khata/features/fuel/application/use_cases/add_fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_calculator.dart';
import 'package:garir_khata/features/fuel/domain/validation/fuel_validator.dart';
import 'package:garir_khata/features/odometer/presentation/widgets/odometer_lower_dialog.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_labels.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_switcher_sheet.dart';
import 'package:go_router/go_router.dart';

class AddEditFuelPage extends ConsumerStatefulWidget {
  const AddEditFuelPage({this.fuelId, super.key});

  final String? fuelId;
  bool get isEditing => fuelId != null;

  @override
  ConsumerState<AddEditFuelPage> createState() => _AddEditFuelPageState();
}

class _AddEditFuelPageState extends ConsumerState<AddEditFuelPage> {
  final _odometer = TextEditingController();
  final _liters = TextEditingController();
  final _total = TextEditingController();
  final _price = TextEditingController();
  final _station = TextEditingController();
  final _location = TextEditingController();
  final _note = TextEditingController();

  DateTime _dateTime = DateTime.now();
  FuelType _fuelType = FuelType.petrol;
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  bool _fullTank = true;
  bool _moreOpen = false;
  bool _saving = false;
  bool _hydrated = false;
  bool _editingPrice = false;
  bool _editingTotal = false;
  String? _error;
  String? _calculatedPriceLabel;

  @override
  void dispose() {
    _odometer.dispose();
    _liters.dispose();
    _total.dispose();
    _price.dispose();
    _station.dispose();
    _location.dispose();
    _note.dispose();
    super.dispose();
  }

  void _recalculate({bool fromTotal = false, bool fromPrice = false}) {
    final double? liters = double.tryParse(_liters.text.trim());
    final double? total = double.tryParse(_total.text.trim());
    final double? price = double.tryParse(_price.text.trim());

    final FuelCalculation? calc = FuelCalculator.calculate(
      liters: liters,
      pricePerLiter: fromTotal ? null : price,
      totalMajor: fromPrice ? null : total,
    );
    if (calc == null) {
      setState(() => _calculatedPriceLabel = null);
      return;
    }

    setState(() {
      if (fromTotal || (!_editingPrice && total != null)) {
        _price.text = (calc.pricePerUnitPaisa! / 100).toStringAsFixed(2);
      } else if (fromPrice || (!_editingTotal && price != null)) {
        _total.text = (calc.totalCostPaisa / 100).toStringAsFixed(2);
      }
      _calculatedPriceLabel =
          '৳ ${(calc.pricePerUnitPaisa! / 100).toStringAsFixed(2)} / L';
    });
  }

  void _hydrate(FuelEntry entry) {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _dateTime = entry.dateTime;
    _odometer.text = '${entry.odometer}';
    _liters.text = entry.quantityLiters.toStringAsFixed(2);
    _total.text = entry.totalCostMajor.toStringAsFixed(2);
    if (entry.pricePerLiterMajor != null) {
      _price.text = entry.pricePerLiterMajor!.toStringAsFixed(2);
    }
    _fuelType = entry.fuelType;
    _fullTank = entry.isFullTank;
    _station.text = entry.stationName ?? '';
    _location.text = entry.locationText ?? '';
    _note.text = entry.note ?? '';
    _paymentMethod = entry.paymentMethod ?? PaymentMethod.cash;
    _calculatedPriceLabel = entry.pricePerLiterMajor == null
        ? null
        : '৳ ${entry.pricePerLiterMajor!.toStringAsFixed(2)} / L';
  }

  FuelInput _toInput(String vehicleId) {
    return FuelInput(
      vehicleId: vehicleId,
      dateTime: _dateTime,
      odometer: int.tryParse(_odometer.text.trim()) ?? -1,
      fuelType: _fuelType,
      isFullTank: _fullTank,
      liters: double.tryParse(_liters.text.trim()),
      pricePerLiter: double.tryParse(_price.text.trim()),
      totalMajor: double.tryParse(_total.text.trim()),
      stationName: _station.text,
      locationText: _location.text,
      paymentMethod: _paymentMethod,
      note: _note.text,
    );
  }

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) {
      return;
    }
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateTime),
    );
    if (time == null) {
      return;
    }
    setState(() {
      _dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save({
    bool allowLower = false,
    bool saveDespiteDuplicate = false,
  }) async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null) {
      setState(() => _error = context.l10n.selectedVehicleNone);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final FuelInput input = _toInput(vehicle.id);

    if (widget.isEditing) {
      final Result<FuelEntry> result = await ref.read(updateFuelEntryProvider)(
        id: widget.fuelId!,
        input: input,
      );
      if (!mounted) {
        return;
      }
      setState(() => _saving = false);
      if (result.isSuccess) {
        ref.invalidate(selectedVehicleProvider);
        ref.invalidate(fuelHistoryProvider(vehicle.id));
        ref.invalidate(selectedVehicleFuelHistoryProvider);
        ref.invalidate(selectedVehicleExpenseHistoryProvider);
        ref.invalidate(dashboardSummaryProvider);
        ref.invalidate(fuelEntryProvider(widget.fuelId!));
        await ref
            .read(reminderEngineProvider)
            .evaluateForVehicle(vehicle.id);
        ref.invalidate(upcomingDashboardRemindersProvider);
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.commonSuccess)),
        );
        context.pop();
      } else {
        setState(() => _error = result.errorOrNull?.message);
      }
      return;
    }

    final Result<AddFuelResult> result = await ref.read(addFuelEntryProvider)(
      input,
      allowLowerOdometer: allowLower,
      saveDespiteDuplicate: saveDespiteDuplicate,
    );

    if (!mounted) {
      return;
    }
    setState(() => _saving = false);

    if (result case Failure(:final error)) {
      if (error is ValidationError && error.code == 'odometer_lower') {
        final action = await showOdometerLowerDialog(
          context,
          previous: vehicle.currentOdometer,
          entered: int.tryParse(_odometer.text.trim()) ?? 0,
        );
        if (action == OdometerLowerAction.reset) {
          await _save(allowLower: true, saveDespiteDuplicate: saveDespiteDuplicate);
        }
        return;
      }
      if (error is ValidationError && error.code == 'fuel_duplicate') {
        final bool? proceed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.duplicateFuelTitle),
            content: Text(context.l10n.duplicateFuelMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(context.l10n.commonCancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(context.l10n.saveAnyway),
              ),
            ],
          ),
        );
        if (proceed == true) {
          await _save(
            allowLower: allowLower,
            saveDespiteDuplicate: true,
          );
        }
        return;
      }
      setState(() => _error = error.message);
      return;
    }

    ref.invalidate(selectedVehicleProvider);
    ref.invalidate(activeVehiclesProvider);
    ref.invalidate(fuelHistoryProvider(vehicle.id));
    ref.invalidate(selectedVehicleFuelHistoryProvider);
    ref.invalidate(selectedVehicleExpenseHistoryProvider);
    ref.invalidate(dashboardSummaryProvider);
    await ref.read(reminderEngineProvider).evaluateForVehicle(vehicle.id);
    ref.invalidate(upcomingDashboardRemindersProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.commonSuccess)),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = ref.watch(selectedVehicleProvider);

    if (widget.isEditing) {
      ref.watch(fuelEntryProvider(widget.fuelId!)).whenData((entry) {
        if (entry != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _hydrate(entry));
            }
          });
        }
      });
    } else {
      selected.whenData((vehicle) {
        if (!_hydrated && vehicle != null && _odometer.text.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _odometer.text = '${vehicle.currentOdometer}';
                _fuelType = vehicle.fuelType;
                _hydrated = true;
              });
            }
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editFuel : l10n.addFuel),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          selected.when(
            data: (vehicle) => Card(
              child: ListTile(
                title: Text(vehicle?.nickname ?? l10n.selectedVehicleNone),
                subtitle: Text(vehicle?.displaySubtitle ?? ''),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () => showVehicleSwitcher(context, ref),
              ),
            ),
            loading: () => Text(l10n.commonLoading),
            error: (_, _) => Text(l10n.commonError),
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: Text(l10n.fieldDateTime),
                    subtitle: Text(
                      MaterialLocalizations.of(context)
                          .formatFullDate(_dateTime),
                    ),
                    onTap: _pickDateTime,
                  ),
                  TextField(
                    controller: _odometer,
                    decoration: InputDecoration(
                      labelText: '${l10n.fieldCurrentOdometer} *',
                      suffixText: 'km',
                      prefixIcon: const Icon(Icons.speed_outlined),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _liters,
                          decoration: InputDecoration(
                            labelText: '${l10n.fieldLiters} *',
                            suffixText: 'L',
                            prefixIcon: const Icon(Icons.local_gas_station),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _recalculate(),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: TextField(
                          controller: _total,
                          decoration: InputDecoration(
                            labelText: '${l10n.fieldTotalAmount} *',
                            prefixText: '৳ ',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) {
                            _editingTotal = true;
                            _editingPrice = false;
                            _recalculate(fromTotal: true);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _price,
                    decoration: InputDecoration(
                      labelText: l10n.fieldPricePerLiter,
                      prefixText: '৳ ',
                      suffixText: '/ L',
                      filled: true,
                      fillColor: AppColors.primary.withValues(alpha: 0.05),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) {
                      _editingPrice = true;
                      _editingTotal = false;
                      _recalculate(fromPrice: true);
                    },
                  ),
                  if (_calculatedPriceLabel != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${l10n.calculated}: $_calculatedPriceLabel',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<FuelType>(
                    // ignore: deprecated_member_use
                    value: _fuelType,
                    decoration: InputDecoration(labelText: l10n.fieldFuelType),
                    items: [
                      for (final FuelType type in FuelType.values)
                        DropdownMenuItem(
                          value: type,
                          child: Text(fuelTypeLabel(context, type)),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _fuelType = value);
                      }
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.fullTankLabel),
                    subtitle: Text(l10n.fullTankHelper),
                    value: _fullTank,
                    activeThumbColor: AppColors.primary,
                    onChanged: (value) => setState(() => _fullTank = value),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Card(
            child: ExpansionTile(
              initiallyExpanded: _moreOpen,
              onExpansionChanged: (open) => setState(() => _moreOpen = open),
              title: Text(l10n.moreDetails),
              childrenPadding: const EdgeInsets.all(AppSpacing.md),
              children: [
                TextField(
                  controller: _station,
                  decoration: InputDecoration(labelText: l10n.fieldStation),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _location,
                  decoration: InputDecoration(labelText: l10n.fieldLocation),
                ),
                const SizedBox(height: AppSpacing.sm),
                DropdownButtonFormField<PaymentMethod>(
                  // ignore: deprecated_member_use
                  value: _paymentMethod,
                  decoration: InputDecoration(labelText: l10n.fieldPayment),
                  items: [
                    for (final PaymentMethod method in PaymentMethod.values)
                      DropdownMenuItem(
                        value: method,
                        child: Text(_paymentLabel(l10n, method)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _paymentMethod = value);
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _note,
                  decoration: InputDecoration(
                    labelText: l10n.fieldNotesOptional,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: _saving ? null : () => _save(),
            icon: const Icon(Icons.save_outlined),
            label: Text(l10n.saveFuelEntry),
          ),
        ],
      ),
    );
  }

  String _paymentLabel(AppLocalizations l10n, PaymentMethod method) {
    return switch (method) {
      PaymentMethod.cash => l10n.paymentCash,
      PaymentMethod.card => l10n.paymentCard,
      PaymentMethod.mobileBanking => l10n.paymentMobile,
      PaymentMethod.other => l10n.paymentOther,
    };
  }
}
