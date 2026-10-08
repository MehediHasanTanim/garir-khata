import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/domain/payment_method.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/expenses/application/expense_providers.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense.dart';
import 'package:garir_khata/features/expenses/domain/entities/expense_category.dart';
import 'package:garir_khata/features/expenses/domain/validation/expense_validator.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddEditExpensePage extends ConsumerStatefulWidget {
  const AddEditExpensePage({this.expenseId, this.initialCategoryCode, super.key});

  final String? expenseId;
  final String? initialCategoryCode;

  bool get isEditing => expenseId != null;

  @override
  ConsumerState<AddEditExpensePage> createState() => _AddEditExpensePageState();
}

class _AddEditExpensePageState extends ConsumerState<AddEditExpensePage> {
  final _amount = TextEditingController();
  final _odometer = TextEditingController();
  final _description = TextEditingController();
  final _vendor = TextEditingController();
  final _note = TextEditingController();

  DateTime _date = DateTime.now();
  String? _categoryId;
  PaymentMethod _payment = PaymentMethod.cash;
  bool _saving = false;
  bool _hydrated = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _odometer.dispose();
    _description.dispose();
    _vendor.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _hydrate(Expense expense) async {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _date = expense.occurredOn;
    _categoryId = expense.categoryId;
    _amount.text = expense.amountMajor.toStringAsFixed(
      expense.amountPaisa % 100 == 0 ? 0 : 2,
    );
    if (expense.odometer != null) {
      _odometer.text = '${expense.odometer}';
    }
    _description.text = expense.description ?? '';
    _vendor.text = expense.vendorName ?? '';
    _note.text = expense.note ?? '';
    _payment = expense.paymentMethod ?? PaymentMethod.cash;
    setState(() {});
  }

  Future<void> _save() async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null) {
      setState(() => _error = context.l10n.selectedVehicleNone);
      return;
    }
    if (_categoryId == null) {
      setState(() => _error = context.l10n.expenseCategoryRequired);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final ExpenseInput input = ExpenseInput(
      vehicleId: vehicle.id,
      occurredOn: _date,
      categoryId: _categoryId!,
      amountMajor: double.tryParse(_amount.text.trim()),
      odometer: int.tryParse(_odometer.text.trim().replaceAll(',', '')),
      description: _description.text,
      vendorName: _vendor.text,
      note: _note.text,
      paymentMethod: _payment,
    );

    final Result<Expense> result;
    if (widget.isEditing) {
      result = await ref.read(updateExpenseProvider)(
        id: widget.expenseId!,
        input: input,
      );
    } else {
      result = await ref.read(addExpenseProvider)(input);
    }

    if (!mounted) {
      return;
    }

    result.when(
      success: (expense) {
        ref.invalidate(selectedVehicleExpenseHistoryProvider);
        ref.invalidate(expenseHistoryProvider(vehicle.id));
        ref.invalidate(dashboardSummaryProvider);
        context.pop(expense.id);
      },
      failure: (error) {
        setState(() {
          _saving = false;
          _error = error.message;
        });
      },
    );
  }

  IconData _iconFor(String iconKey) {
    return switch (iconKey) {
      'fuel' => Icons.local_gas_station,
      'maintenance' => Icons.build_circle_outlined,
      'repair' => Icons.handyman_outlined,
      'engine_oil' => Icons.water_drop_outlined,
      'parts' => Icons.settings_outlined,
      'tyres' => Icons.trip_origin,
      'battery' => Icons.battery_charging_full_outlined,
      'cleaning' => Icons.local_car_wash_outlined,
      'tax' || 'fitness' || 'registration' => Icons.badge_outlined,
      'insurance' => Icons.health_and_safety_outlined,
      'parking' || 'toll' => Icons.paid_outlined,
      'fine' => Icons.gavel_outlined,
      'loan' => Icons.account_balance_outlined,
      _ => Icons.category_outlined,
    };
  }

  Color _colorFor(String group) {
    return switch (group) {
      'fuel' => AppColors.fuel,
      'maintenance' => AppColors.maintenance,
      'repair' => AppColors.repair,
      _ => AppColors.other,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categoriesAsync = ref.watch(expenseCategoriesProvider);
    final languageCode = Localizations.localeOf(context).languageCode;

    if (widget.isEditing) {
      ref.watch(expenseByIdProvider(widget.expenseId!)).whenData((expense) {
        if (expense != null) {
          _hydrate(expense);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editExpense : l10n.addExpense),
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (categories) {
          if (_categoryId == null && categories.isNotEmpty) {
            final ExpenseCategory? preferred = widget.initialCategoryCode == null
                ? null
                : categories
                    .where((c) => c.code == widget.initialCategoryCode)
                    .firstOrNull;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_categoryId == null && mounted) {
                setState(() {
                  _categoryId = preferred?.id ??
                      categories
                          .where((c) => c.code != 'fuel')
                          .firstOrNull
                          ?.id ??
                      categories.first.id;
                });
              }
            });
          }

          final List<ExpenseCategory> selectable = categories
              .where((c) => c.code != 'fuel' || widget.isEditing)
              .toList();

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(l10n.expenseCategory, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: selectable.map((category) {
                  final bool selected = category.id == _categoryId;
                  final Color color = _colorFor(category.dashboardGroup);
                  return ChoiceChip(
                    selected: selected,
                    avatar: Icon(
                      _iconFor(category.iconKey),
                      size: 18,
                      color: selected ? Colors.white : color,
                    ),
                    label: Text(category.localizedName(languageCode)),
                    selectedColor: color,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : null,
                    ),
                    onSelected: (_) => setState(() => _categoryId = category.id),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.fieldDate),
                subtitle: Text(
                  MaterialLocalizations.of(context).formatMediumDate(_date),
                ),
                trailing: const Icon(Icons.calendar_today_outlined),
                onTap: _pickDate,
              ),
              TextFormField(
                controller: _odometer,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l10n.fieldOdometerOptional,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(labelText: l10n.fieldExpenseTitle),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: l10n.fieldAmount,
                  prefixText: '৳ ',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _vendor,
                decoration: InputDecoration(labelText: l10n.fieldVendorOptional),
              ),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<PaymentMethod>(
                // ignore: deprecated_member_use
                value: _payment,
                decoration: InputDecoration(labelText: l10n.fieldPayment),
                items: [
                  DropdownMenuItem(
                    value: PaymentMethod.cash,
                    child: Text(l10n.paymentCash),
                  ),
                  DropdownMenuItem(
                    value: PaymentMethod.card,
                    child: Text(l10n.paymentCard),
                  ),
                  DropdownMenuItem(
                    value: PaymentMethod.mobileBanking,
                    child: Text(l10n.paymentMobile),
                  ),
                  DropdownMenuItem(
                    value: PaymentMethod.other,
                    child: Text(l10n.paymentOther),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _payment = value);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _note,
                maxLines: 3,
                decoration: InputDecoration(labelText: l10n.fieldNotesOptional),
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(_error!, style: const TextStyle(color: AppColors.destructive)),
              ],
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Text(_saving ? l10n.commonLoading : l10n.commonSave),
              ),
            ],
          );
        },
      ),
    );
  }
}
