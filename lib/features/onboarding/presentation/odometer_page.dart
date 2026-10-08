import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/onboarding/application/onboarding_controller.dart';
import 'package:garir_khata/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:go_router/go_router.dart';

class OdometerPage extends ConsumerStatefulWidget {
  const OdometerPage({super.key});

  @override
  ConsumerState<OdometerPage> createState() => _OdometerPageState();
}

class _OdometerPageState extends ConsumerState<OdometerPage> {
  late final TextEditingController _odometer;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(onboardingControllerProvider);
    _odometer = TextEditingController(
      text: draft.currentOdometer > 0 ? '${draft.currentOdometer}' : '',
    );
  }

  @override
  void dispose() {
    _odometer.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final int? value = int.tryParse(_odometer.text.trim());
    if (value == null || value < 0) {
      setState(() => _error = l10n.validationOdometer);
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });
    ref.read(onboardingControllerProvider.notifier).setOdometer(value);
    final result = await ref
        .read(onboardingControllerProvider.notifier)
        .submit();
    if (!mounted) {
      return;
    }
    setState(() => _saving = false);
    result.when(
      success: (_) => context.go('/onboarding/complete'),
      failure: (error) => setState(() => _error = error.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return OnboardingScaffold(
      step: 6,
      totalSteps: 7,
      title: l10n.currentOdometerTitle,
      subtitle: l10n.currentOdometerHint,
      primaryLabel: l10n.finishSetup,
      isPrimaryLoading: _saving,
      onBack: () {
        final int? value = int.tryParse(_odometer.text.trim());
        if (value != null) {
          ref.read(onboardingControllerProvider.notifier).setOdometer(value);
        }
        context.go('/onboarding/vehicle-details');
      },
      onPrimary: _submit,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: const Icon(
                  Icons.speed,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _odometer,
                autofocus: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
                decoration: InputDecoration(
                  labelText: l10n.fieldCurrentOdometer,
                  suffixText: 'km',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
