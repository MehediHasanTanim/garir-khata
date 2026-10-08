import 'package:flutter/material.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';

/// Reusable empty / loading / error / permission surfaces for Sprint 10.
class AppLoadingState extends StatelessWidget {
  const AppLoadingState({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: message ?? 'Loading',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(message!),
            ],
          ],
        ),
      ),
    );
  }
}

class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({this.itemCount = 6, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: itemCount,
      itemBuilder: (_, _) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: base.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Semantics(
          label: '$title. ${subtitle ?? ''}',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: AppColors.textSecondary),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: AppSpacing.md),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AppNoSearchResult extends StatelessWidget {
  const AppNoSearchResult({required this.query, super.key});

  final String query;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: 'No results',
      subtitle: 'Nothing matched “$query”.',
      icon: Icons.search_off_outlined,
    );
  }
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.message,
    this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Semantics(
          liveRegion: true,
          label: message,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.destructive, size: 40),
              const SizedBox(height: AppSpacing.md),
              Text(message, textAlign: TextAlign.center),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.md),
                FilledButton(onPressed: onRetry, child: const Text('Retry')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AppPermissionDeniedState extends StatelessWidget {
  const AppPermissionDeniedState({
    required this.message,
    this.onOpenSettings,
    super.key,
  });

  final String message;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: message,
      icon: Icons.lock_outline,
      action: onOpenSettings == null
          ? null
          : OutlinedButton(
              onPressed: onOpenSettings,
              child: const Text('Open settings'),
            ),
    );
  }
}

class CalculationUnavailableBanner extends StatelessWidget {
  const CalculationUnavailableBanner({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: MaterialBanner(
        content: Text(message),
        leading: const Icon(Icons.info_outline),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

Future<bool> showAppDeleteConfirmation(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Delete',
  String cancelLabel = 'Cancel',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.destructive,
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<bool> showUnsavedChangesDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Unsaved changes'),
      content: const Text('Discard your changes?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Keep editing'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Discard'),
        ),
      ],
    ),
  );
  return result ?? false;
}

void showSaveFeedback(
  BuildContext context, {
  required bool success,
  String? message,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        message ?? (success ? 'Saved successfully' : 'Save failed'),
      ),
      backgroundColor: success ? AppColors.success : AppColors.destructive,
    ),
  );
}
