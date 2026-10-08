import 'package:flutter/material.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return OnboardingScaffold(
      step: 3,
      totalSteps: 7,
      title: l10n.welcomeTitle,
      subtitle: l10n.welcomeSubtitle,
      primaryLabel: l10n.addVehicle,
      onBack: () => context.go('/onboarding/language'),
      onPrimary: () => context.go('/onboarding/vehicle-type'),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 72,
                  color: AppColors.primary,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.welcomeHeadline,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(color: AppColors.primaryDark),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.welcomeBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            alignment: WrapAlignment.center,
            children: [
              _FeatureChip(icon: Icons.local_gas_station, label: l10n.fuel),
              _FeatureChip(icon: Icons.speed, label: l10n.mileage),
              _FeatureChip(icon: Icons.build, label: l10n.service),
              _FeatureChip(icon: Icons.settings_suggest, label: l10n.repairs),
              _FeatureChip(icon: Icons.description, label: l10n.documents),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.12),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
