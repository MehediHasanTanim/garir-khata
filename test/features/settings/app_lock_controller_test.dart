import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/features/settings/application/app_lock_controller.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/settings/data/secure_credentials_store.dart';
import 'package:garir_khata/features/settings/domain/preference_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> container() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        secureCredentialsStoreProvider.overrideWithValue(
          SecureCredentialsStore(storage: MemorySecureKeyValueStore()),
        ),
      ],
    );
  }

  test('setPin enables lock and unlocks session', () async {
    final c = await container();
    addTearDown(c.dispose);

    final result =
        await c.read(appLockControllerProvider.notifier).setPin('1357');
    expect(result.isSuccess, isTrue);
    expect(c.read(settingsControllerProvider).pinEnabled, isTrue);
    expect(c.read(appLockControllerProvider).isLocked, isFalse);
  });

  test('unlockWithPin rejects wrong pin', () async {
    final c = await container();
    addTearDown(c.dispose);
    final lock = c.read(appLockControllerProvider.notifier);
    await lock.setPin('1357');
    lock.lockNow();
    expect(c.read(appLockControllerProvider).isLocked, isTrue);

    final bad = await lock.unlockWithPin('0000');
    expect(bad.isFailure, isTrue);
    expect(c.read(appLockControllerProvider).isLocked, isTrue);

    final good = await lock.unlockWithPin('1357');
    expect(good.isSuccess, isTrue);
    expect(c.read(appLockControllerProvider).isLocked, isFalse);
  });

  test('disablePin clears credentials and biometrics flag', () async {
    final c = await container();
    addTearDown(c.dispose);
    final settings = c.read(settingsControllerProvider.notifier);
    final lock = c.read(appLockControllerProvider.notifier);
    await lock.setPin('1357');
    await settings.setBiometricsEnabled(true);

    final result = await lock.disablePin('1357');
    expect(result.isSuccess, isTrue);
    expect(c.read(settingsControllerProvider).pinEnabled, isFalse);
    expect(c.read(settingsControllerProvider).biometricsEnabled, isFalse);
  });

  test('auto-lock after timeout on resume', () async {
    final c = await container();
    addTearDown(c.dispose);
    final settings = c.read(settingsControllerProvider.notifier);
    final lock = c.read(appLockControllerProvider.notifier);
    await lock.setPin('1357');
    await settings.setAutoLockTimeout(AutoLockTimeout.immediately);

    lock.onPaused();
    lock.onResumed();
    expect(c.read(appLockControllerProvider).isLocked, isTrue);
  });
}
