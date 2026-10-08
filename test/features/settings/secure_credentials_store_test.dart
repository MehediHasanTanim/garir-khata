import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/settings/data/secure_credentials_store.dart';

class _FixedUuid implements UuidGenerator {
  const _FixedUuid(this.value);
  final String value;
  @override
  String v4() => value;
}

void main() {
  test('stores hashed PIN and verifies correctly', () async {
    final store = SecureCredentialsStore(
      storage: MemorySecureKeyValueStore(),
      uuidGenerator: const _FixedUuid('salt-1'),
    );

    expect(await store.hasPin(), isFalse);
    await store.setPin('1234');
    expect(await store.hasPin(), isTrue);
    expect(await store.verifyPin('1234'), isTrue);
    expect(await store.verifyPin('9999'), isFalse);
  });

  test('clearPin removes credentials', () async {
    final store = SecureCredentialsStore(
      storage: MemorySecureKeyValueStore(),
      uuidGenerator: const _FixedUuid('salt-2'),
    );
    await store.setPin('2468');
    await store.clearPin();
    expect(await store.hasPin(), isFalse);
    expect(await store.verifyPin('2468'), isFalse);
  });
}
