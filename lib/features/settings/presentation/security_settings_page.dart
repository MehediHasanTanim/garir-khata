import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/ui/app_states.dart';
import 'package:garir_khata/features/settings/application/app_lock_controller.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/settings/domain/preference_enums.dart';
import 'package:go_router/go_router.dart';

class SecuritySettingsPage extends ConsumerWidget {
  const SecuritySettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final lock = ref.read(appLockControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsSecurity)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.appLockPin),
            subtitle: Text(
              settings.pinEnabled ? l10n.appLockEnabled : l10n.appLockDisabled,
            ),
            value: settings.pinEnabled,
            onChanged: (enabled) async {
              if (enabled) {
                await context.push('/settings/security/set-pin');
              } else {
                final pin = await _askPin(context, l10n.verifyPinTitle);
                if (pin == null || !context.mounted) {
                  return;
                }
                final result = await lock.disablePin(pin);
                if (!context.mounted) {
                  return;
                }
                showSaveFeedback(
                  context,
                  success: result.isSuccess,
                  message: result.isSuccess
                      ? l10n.appLockDisabled
                      : result.errorOrNull?.message,
                );
              }
            },
          ),
          if (settings.pinEnabled) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.changePin),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/security/change-pin'),
            ),
            FutureBuilder<bool>(
              future: lock.canCheckBiometrics(),
              builder: (context, snap) {
                final supported = snap.data ?? false;
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.biometrics),
                  subtitle: Text(
                    supported
                        ? l10n.biometricsHint
                        : l10n.biometricsUnavailable,
                  ),
                  value: settings.biometricsEnabled && supported,
                  onChanged: !supported
                      ? null
                      : (v) => controller.setBiometricsEnabled(v),
                );
              },
            ),
            Text(l10n.autoLock, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            DropdownButtonFormField<AutoLockTimeout>(
              // ignore: deprecated_member_use
              value: settings.autoLockTimeout,
              items: AutoLockTimeout.values
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text(_timeoutLabel(context, t)),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  controller.setAutoLockTimeout(v);
                }
              },
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.hideSensitivePreview),
            subtitle: Text(l10n.hideSensitivePreviewHint),
            value: settings.hideSensitivePreview,
            onChanged: controller.setHideSensitivePreview,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: settings.pinEnabled ? () => lock.lockNow() : null,
            child: Text(l10n.lockNow),
          ),
        ],
      ),
    );
  }

  String _timeoutLabel(BuildContext context, AutoLockTimeout t) {
    final l10n = context.l10n;
    return switch (t) {
      AutoLockTimeout.immediately => l10n.autoLockImmediately,
      AutoLockTimeout.thirtySeconds => l10n.autoLockThirtySeconds,
      AutoLockTimeout.oneMinute => l10n.autoLockOneMinute,
      AutoLockTimeout.fiveMinutes => l10n.autoLockFiveMinutes,
      AutoLockTimeout.never => l10n.autoLockNever,
    };
  }

  Future<String?> _askPin(BuildContext context, String title) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(context.l10n.commonContinue),
          ),
        ],
      ),
    );
  }
}
