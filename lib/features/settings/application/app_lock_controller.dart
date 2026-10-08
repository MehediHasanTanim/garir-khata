import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/settings/data/secure_credentials_store.dart';
import 'package:garir_khata/features/settings/domain/preference_enums.dart';
import 'package:local_auth/local_auth.dart';

class AppLockState {
  const AppLockState({
    this.isLocked = false,
    this.isBackgroundCovered = false,
    this.lastPausedAt,
  });

  final bool isLocked;
  final bool isBackgroundCovered;
  final DateTime? lastPausedAt;

  AppLockState copyWith({
    bool? isLocked,
    bool? isBackgroundCovered,
    DateTime? lastPausedAt,
    bool clearPausedAt = false,
  }) {
    return AppLockState(
      isLocked: isLocked ?? this.isLocked,
      isBackgroundCovered: isBackgroundCovered ?? this.isBackgroundCovered,
      lastPausedAt:
          clearPausedAt ? null : (lastPausedAt ?? this.lastPausedAt),
    );
  }
}

class AppLockController extends Notifier<AppLockState> {
  SecureCredentialsStore get _store =>
      ref.read(secureCredentialsStoreProvider);
  LocalAuthentication get _auth => LocalAuthentication();

  @override
  AppLockState build() {
    // Read once at create — do not watch settings or every prefs write re-locks.
    final settings = ref.read(settingsControllerProvider);
    return AppLockState(isLocked: settings.pinEnabled);
  }

  void onPaused() {
    final settings = ref.read(settingsControllerProvider);
    state = state.copyWith(
      lastPausedAt: DateTime.now(),
      isBackgroundCovered: settings.hideSensitivePreview,
    );
  }

  void onResumed() {
    final settings = ref.read(settingsControllerProvider);
    final covered = state.isBackgroundCovered;
    state = state.copyWith(isBackgroundCovered: false);

    if (!settings.pinEnabled) {
      state = state.copyWith(isLocked: false, clearPausedAt: true);
      return;
    }

    final timeout = settings.autoLockTimeout.duration;
    if (timeout == null) {
      // never auto-lock on resume; keep current lock state
      return;
    }

    final paused = state.lastPausedAt;
    if (paused == null) {
      if (covered || timeout == Duration.zero) {
        state = state.copyWith(isLocked: true);
      }
      return;
    }
    final elapsed = DateTime.now().difference(paused);
    if (elapsed >= timeout) {
      state = state.copyWith(isLocked: true, clearPausedAt: true);
    }
  }

  Future<Result<void>> setPin(String pin) async {
    if (!_isValidPin(pin)) {
      return const Failure(
        ValidationError(message: 'PIN must be 4–6 digits', field: 'pin'),
      );
    }
    await _store.setPin(pin);
    await ref.read(settingsControllerProvider.notifier).setPinEnabled(true);
    state = state.copyWith(isLocked: false);
    return const Success(null);
  }

  Future<Result<void>> changePin({
    required String currentPin,
    required String newPin,
  }) async {
    final ok = await _store.verifyPin(currentPin);
    if (!ok) {
      return const Failure(ValidationError(message: 'Current PIN is incorrect'));
    }
    return setPin(newPin);
  }

  Future<Result<void>> disablePin(String currentPin) async {
    final ok = await _store.verifyPin(currentPin);
    if (!ok) {
      return const Failure(ValidationError(message: 'PIN is incorrect'));
    }
    await _store.clearPin();
    await ref.read(settingsControllerProvider.notifier).setPinEnabled(false);
    await ref
        .read(settingsControllerProvider.notifier)
        .setBiometricsEnabled(false);
    state = state.copyWith(isLocked: false);
    return const Success(null);
  }

  Future<Result<void>> unlockWithPin(String pin) async {
    final ok = await _store.verifyPin(pin);
    if (!ok) {
      return const Failure(ValidationError(message: 'Incorrect PIN'));
    }
    state = state.copyWith(isLocked: false, clearPausedAt: true);
    return const Success(null);
  }

  Future<Result<void>> unlockWithBiometrics() async {
    final settings = ref.read(settingsControllerProvider);
    if (!settings.biometricsEnabled || !settings.pinEnabled) {
      return const Failure(
        ValidationError(message: 'Biometrics are not enabled'),
      );
    }
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) {
        return const Failure(
          ValidationError(message: 'Biometrics not available on this device'),
        );
      }
      final didAuth = await _auth.authenticate(
        localizedReason: 'Unlock Garir Khata',
        biometricOnly: true,
      );
      if (!didAuth) {
        return const Failure(ValidationError(message: 'Biometric unlock failed'));
      }
      state = state.copyWith(isLocked: false, clearPausedAt: true);
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        PermissionError(message: 'Biometric authentication failed', cause: error),
      );
    }
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } on Object {
      return false;
    }
  }

  void lockNow() {
    if (ref.read(settingsControllerProvider).pinEnabled) {
      state = state.copyWith(isLocked: true);
    }
  }

  bool _isValidPin(String pin) {
    if (pin.length < 4 || pin.length > 6) {
      return false;
    }
    return RegExp(r'^\d+$').hasMatch(pin);
  }
}

final appLockControllerProvider =
    NotifierProvider<AppLockController, AppLockState>(AppLockController.new);
