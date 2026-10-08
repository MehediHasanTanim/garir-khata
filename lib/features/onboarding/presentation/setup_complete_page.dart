import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/onboarding/application/onboarding_controller.dart';
import 'package:garir_khata/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_labels.dart';
import 'package:go_router/go_router.dart';

class SetupCompletePage extends ConsumerWidget {
  const SetupCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(onboardingControllerProvider);
    final selected = ref.watch(selectedVehicleProvider);

    return OnboardingScaffold(
      step: 7,
      totalSteps: 7,
      title: l10n.setupCompleteTitle,
      subtitle: l10n.setupCompleteSubtitle,
      primaryLabel: l10n.goToDashboard,
      onPrimary: () {
        ref.read(onboardingControllerProvider.notifier).reset();
        context.go('/home');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundColor: Color(0x1A0D7A70),
                child: Icon(Icons.check, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.setupCompleteHeadline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              selected.when(
                data: (vehicle) {
                  final name = vehicle?.nickname ?? draft.nickname;
                  final fuel = vehicle?.fuelType ?? draft.fuelType;
                  final odo = vehicle?.currentOdometer ?? draft.currentOdometer;
                  return Column(
                    children: [
                      Text(name, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${fuelTypeLabel(context, fuel)} · $odo km',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                },
                loading: () => Text(l10n.commonLoading),
                error: (_, _) => Text(draft.nickname),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
