import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/settings/application/app_lock_controller.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';

/// Full-screen lock + optional background privacy cover.
class AppSecurityHost extends ConsumerStatefulWidget {
  const AppSecurityHost({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppSecurityHost> createState() => _AppSecurityHostState();
}

class _AppSecurityHostState extends ConsumerState<AppSecurityHost>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final lock = ref.read(appLockControllerProvider.notifier);
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        lock.onPaused();
      case AppLifecycleState.resumed:
        lock.onResumed();
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lockState = ref.watch(appLockControllerProvider);
    final settings = ref.watch(settingsControllerProvider);

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (lockState.isBackgroundCovered && settings.hideSensitivePreview)
          const ColoredBox(
            color: AppColors.primaryDark,
            child: Center(
              child: Text(
                'Garir Khata',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
        if (lockState.isLocked && settings.pinEnabled)
          const _UnlockOverlay(),
      ],
    );
  }
}

class _UnlockOverlay extends ConsumerStatefulWidget {
  const _UnlockOverlay();

  @override
  ConsumerState<_UnlockOverlay> createState() => _UnlockOverlayState();
}

class _UnlockOverlayState extends ConsumerState<_UnlockOverlay> {
  String _pin = '';
  String? _error;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);
    final lock = ref.read(appLockControllerProvider.notifier);

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              const Icon(Icons.lock_outline, size: 48, color: AppColors.primary),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.unlockTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (i) {
                  final filled = i < _pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled
                          ? AppColors.primary
                          : AppColors.divider,
                    ),
                  );
                }),
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    _error!,
                    style: const TextStyle(color: AppColors.destructive),
                  ),
                ),
              ],
              const Spacer(),
              _Keypad(
                enabled: !_busy,
                onDigit: (d) async {
                  if (_pin.length >= 6) {
                    return;
                  }
                  setState(() {
                    _pin += d;
                    _error = null;
                  });
                  if (_pin.length >= 4) {
                    // Auto-attempt when user stops? Require explicit length 4-6 via OK.
                  }
                },
                onBackspace: () {
                  if (_pin.isEmpty) {
                    return;
                  }
                  setState(() => _pin = _pin.substring(0, _pin.length - 1));
                },
                onSubmit: () async {
                  if (_pin.length < 4) {
                    setState(() => _error = l10n.pinTooShort);
                    return;
                  }
                  setState(() => _busy = true);
                  final result = await lock.unlockWithPin(_pin);
                  setState(() {
                    _busy = false;
                    if (result.isFailure) {
                      _error = result.errorOrNull?.message;
                      _pin = '';
                    }
                  });
                },
              ),
              if (settings.biometricsEnabled)
                TextButton.icon(
                  onPressed: _busy
                      ? null
                      : () async {
                          setState(() => _busy = true);
                          final result = await lock.unlockWithBiometrics();
                          setState(() {
                            _busy = false;
                            if (result.isFailure) {
                              _error = result.errorOrNull?.message;
                            }
                          });
                        },
                  icon: const Icon(Icons.fingerprint),
                  label: Text(l10n.unlockWithBiometrics),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.onDigit,
    required this.onBackspace,
    required this.onSubmit,
    required this.enabled,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback onSubmit;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['⌫', '0', 'OK'],
    ];
    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((key) {
            return SizedBox(
              width: 72,
              height: AppSpacing.touchTarget + 8,
              child: TextButton(
                onPressed: !enabled
                    ? null
                    : () {
                        if (key == '⌫') {
                          onBackspace();
                        } else if (key == 'OK') {
                          onSubmit();
                        } else {
                          onDigit(key);
                        }
                      },
                child: Text(key, style: Theme.of(context).textTheme.titleLarge),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
