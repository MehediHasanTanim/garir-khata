import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/reminders/application/use_cases/upsert_reminder.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddEditReminderPage extends ConsumerStatefulWidget {
  const AddEditReminderPage({this.reminderId, super.key});

  final String? reminderId;
  bool get isEditing => reminderId != null;

  @override
  ConsumerState<AddEditReminderPage> createState() =>
      _AddEditReminderPageState();
}

class _AddEditReminderPageState extends ConsumerState<AddEditReminderPage> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _odometer = TextEditingController();
  final _advanceDays = TextEditingController(text: '30');
  final _advanceKm = TextEditingController(text: '500');

  ReminderKind _kind = ReminderKind.date;
  DateTime? _dueDate;
  bool _notifications = true;
  bool _hydrated = false;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _odometer.dispose();
    _advanceDays.dispose();
    _advanceKm.dispose();
    super.dispose();
  }

  void _hydrate(Reminder reminder) {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _title.text = reminder.title;
    _description.text = reminder.description ?? '';
    _kind = reminder.reminderType;
    _dueDate = reminder.dueDate;
    if (reminder.dueOdometer != null) {
      _odometer.text = '${reminder.dueOdometer}';
    }
    _advanceDays.text = '${reminder.advanceDays}';
    _advanceKm.text = '${reminder.advanceKm}';
    _notifications = reminder.notificationEnabled;
    setState(() {});
  }

  Future<void> _pickDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
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
    final Result<Reminder> result = await ref.read(upsertReminderProvider)(
      ReminderInput(
        id: widget.reminderId,
        vehicleId: vehicle.id,
        title: _title.text,
        description: _description.text,
        reminderType: _kind,
        dueDate: _dueDate,
        dueOdometer: int.tryParse(_odometer.text.trim()),
        advanceDays: int.tryParse(_advanceDays.text.trim()) ?? 30,
        advanceKm: int.tryParse(_advanceKm.text.trim()) ?? 500,
        relatedEntityType: ReminderEntityType.custom,
        notificationEnabled: _notifications,
      ),
    );
    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehicleRemindersProvider);
        ref.invalidate(upcomingDashboardRemindersProvider);
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
    if (widget.isEditing) {
      ref.watch(reminderByIdProvider(widget.reminderId!)).whenData((reminder) {
        if (reminder != null) {
          _hydrate(reminder);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editReminder : l10n.addReminder),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          TextFormField(
            controller: _title,
            decoration: InputDecoration(labelText: l10n.fieldReminderTitle),
          ),
          TextFormField(
            controller: _description,
            decoration: InputDecoration(labelText: l10n.fieldNotesOptional),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.reminderType, style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              ChoiceChip(
                label: Text(l10n.reminderTypeDate),
                selected: _kind == ReminderKind.date,
                onSelected: (_) => setState(() => _kind = ReminderKind.date),
              ),
              ChoiceChip(
                label: Text(l10n.reminderTypeOdometer),
                selected: _kind == ReminderKind.odometer,
                onSelected: (_) =>
                    setState(() => _kind = ReminderKind.odometer),
              ),
              ChoiceChip(
                label: Text(l10n.reminderTypeCombined),
                selected: _kind == ReminderKind.combined,
                onSelected: (_) =>
                    setState(() => _kind = ReminderKind.combined),
              ),
            ],
          ),
          if (_kind != ReminderKind.odometer)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.fieldDueDate),
              subtitle: Text(
                _dueDate == null
                    ? l10n.optional
                    : MaterialLocalizations.of(context)
                        .formatMediumDate(_dueDate!),
              ),
              onTap: _pickDueDate,
            ),
          if (_kind != ReminderKind.date)
            TextFormField(
              controller: _odometer,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: l10n.fieldDueOdometer),
            ),
          TextFormField(
            controller: _advanceDays,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldAdvanceDays),
          ),
          TextFormField(
            controller: _advanceKm,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.fieldAdvanceKm),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.enableNotifications),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: AppColors.destructive)),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? l10n.commonLoading : l10n.saveReminder),
          ),
        ],
      ),
    );
  }
}
