import 'package:flutter/material.dart';

import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    required this.step,
    required this.totalSteps,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.primaryLabel,
    required this.onPrimary,
    this.onBack,
    this.secondary,
    this.isPrimaryEnabled = true,
    this.isPrimaryLoading = false,
    super.key,
  });

  final int step;
  final int totalSteps;
  final String title;
  final String subtitle;
  final Widget child;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final VoidCallback? onBack;
  final Widget? secondary;
  final bool isPrimaryEnabled;
  final bool isPrimaryLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Row(
                children: [
                  if (onBack != null)
                    IconButton.filledTonal(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _StepProgress(step: step, totalSteps: totalSteps),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: child,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: isPrimaryEnabled && !isPrimaryLoading
                        ? onPrimary
                        : null,
                    child: isPrimaryLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(primaryLabel),
                              const SizedBox(width: AppSpacing.xs),
                              const Icon(Icons.arrow_forward, size: 18),
                            ],
                          ),
                  ),
                  if (secondary != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    secondary!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.step, required this.totalSteps});

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= totalSteps; i++) ...[
              Container(
                width: i <= step ? 10 : 8,
                height: i <= step ? 10 : 8,
                decoration: BoxDecoration(
                  color: i <= step ? AppColors.primary : AppColors.divider,
                  shape: BoxShape.circle,
                ),
              ),
              if (i < totalSteps)
                Container(
                  width: 12,
                  height: 2,
                  color: i < step ? AppColors.primary : AppColors.divider,
                ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text('$step/$totalSteps', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
