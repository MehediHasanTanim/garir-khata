import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:go_router/go_router.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  ConsumerState<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguagePage> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = ref.read(settingsControllerProvider).locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return OnboardingScaffold(
      step: 2,
      totalSteps: 7,
      title: l10n.chooseLanguageTitle,
      subtitle: l10n.chooseLanguageSubtitle,
      primaryLabel: l10n.commonContinue,
      onPrimary: () async {
        await ref
            .read(settingsControllerProvider.notifier)
            .setLocale(Locale(_selected), confirm: true);
        if (context.mounted) {
          context.go('/onboarding/welcome');
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: const Icon(Icons.language, color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.chooseLanguageHint,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              _LanguageOption(
                code: 'bn',
                title: l10n.languageBangla,
                subtitle: l10n.languageBanglaHint,
                glyph: 'অ',
                selected: _selected == 'bn',
                onTap: () => setState(() => _selected = 'bn'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _LanguageOption(
                code: 'en',
                title: l10n.languageEnglish,
                subtitle: l10n.languageEnglishHint,
                glyph: 'Aa',
                selected: _selected == 'en',
                onTap: () => setState(() => _selected = 'en'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.glyph,
    required this.selected,
    required this.onTap,
  });

  final String code;
  final String title;
  final String subtitle;
  final String glyph;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
            width: selected ? 1.5 : 1,
          ),
          color: selected
              ? AppColors.primary.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: selected
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : AppColors.divider,
              child: Text(
                glyph,
                style: TextStyle(
                  color: selected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
