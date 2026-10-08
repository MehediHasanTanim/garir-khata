import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';

/// Minimal key-value port so PIN hashing can be unit-tested without plugins.
abstract class SecureKeyValueStore {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String value});
  Future<void> delete({required String key});
}

class FlutterSecureKeyValueStore implements SecureKeyValueStore {
  FlutterSecureKeyValueStore([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(),
            );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read({required String key}) => _storage.read(key: key);

  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete({required String key}) => _storage.delete(key: key);
}

class MemorySecureKeyValueStore implements SecureKeyValueStore {
  final Map<String, String> _data = {};

  @override
  Future<String?> read({required String key}) async => _data[key];

  @override
  Future<void> write({required String key, required String value}) async {
    _data[key] = value;
  }

  @override
  Future<void> delete({required String key}) async {
    _data.remove(key);
  }
}

/// PIN secrets — never SharedPreferences.
class SecureCredentialsStore {
  SecureCredentialsStore({
    SecureKeyValueStore? storage,
    UuidGenerator? uuidGenerator,
  })  : _storage = storage ?? FlutterSecureKeyValueStore(),
        _uuid = uuidGenerator ?? const DefaultUuidGenerator();

  final SecureKeyValueStore _storage;
  final UuidGenerator _uuid;

  static const _pinHashKey = 'security.pin_hash';
  static const _pinSaltKey = 'security.pin_salt';

  Future<bool> hasPin() async {
    final hash = await _storage.read(key: _pinHashKey);
    return hash != null && hash.isNotEmpty;
  }

  Future<void> setPin(String pin) async {
    final salt = _uuid.v4();
    final hash = _hash(pin, salt);
    await _storage.write(key: _pinSaltKey, value: salt);
    await _storage.write(key: _pinHashKey, value: hash);
  }

  Future<bool> verifyPin(String pin) async {
    final salt = await _storage.read(key: _pinSaltKey);
    final hash = await _storage.read(key: _pinHashKey);
    if (salt == null || hash == null) {
      return false;
    }
    return _hash(pin, salt) == hash;
  }

  Future<void> clearPin() async {
    await _storage.delete(key: _pinHashKey);
    await _storage.delete(key: _pinSaltKey);
  }

  String _hash(String pin, String salt) {
    final bytes = utf8.encode('$salt:$pin');
    return sha256.convert(bytes).toString();
  }
}
