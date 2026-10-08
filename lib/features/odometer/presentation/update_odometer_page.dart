import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/odometer/application/odometer_providers.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/odometer/presentation/widgets/odometer_lower_dialog.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class UpdateOdometerPage extends ConsumerStatefulWidget {
  const UpdateOdometerPage({super.key});

  @override
  ConsumerState<UpdateOdometerPage> createState() => _UpdateOdometerPageState();
}

class _UpdateOdometerPageState extends ConsumerState<UpdateOdometerPage> {
  final _odometer = TextEditingController();
  final _note = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _odometer.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save({bool allowLower = false, bool asReset = false}) async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null) {
      setState(() => _error = context.l10n.selectedVehicleNone);
      return;
    }
    final int? value = int.tryParse(_odometer.text.trim());
    if (value == null) {
      setState(() => _error = context.l10n.validationOdometer);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final Result<OdometerEntry> result =
        await ref.read(addOdometerReadingProvider)(
      vehicleId: vehicle.id,
      odometer: value,
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      allowLower: allowLower,
      asReset: asReset,
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
          entered: value,
        );
        if (action == OdometerLowerAction.reset) {
          await _save(allowLower: true, asReset: true);
        }
        return;
      }
      setState(() => _error = error.message);
      return;
    }

    ref.invalidate(selectedVehicleProvider);
    ref.invalidate(activeVehiclesProvider);
    ref.invalidate(odometerHistoryProvider(vehicle.id));
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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.updateOdometer),
        actions: [
          TextButton(
            onPressed: () => context.push('/odometer/history'),
            child: Text(l10n.odometerHistory),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          selected.when(
            data: (vehicle) => Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle?.nickname ?? l10n.selectedVehicleNone,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${l10n.fieldCurrentOdometer}: ${vehicle?.currentOdometer ?? 0} km',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            loading: () => Text(l10n.commonLoading),
            error: (_, _) => Text(l10n.commonError),
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    child: const Icon(Icons.speed, color: AppColors.primary),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _odometer,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                    decoration: InputDecoration(
                      labelText: l10n.fieldNewOdometer,
                      suffixText: 'km',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: AppSpacing.md),
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
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : () => _save(),
            child: _saving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
