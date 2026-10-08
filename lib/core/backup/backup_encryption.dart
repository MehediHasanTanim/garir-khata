import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';

/// Binary envelope for `.gkbackup` files.
///
/// Unencrypted: `GKB0` + zip bytes
/// Encrypted:   `GKB1` + salt(16) + nonce(12) + mac(16) + ciphertext
abstract final class BackupEncryption {
  static const List<int> magicPlain = [0x47, 0x4B, 0x42, 0x30]; // GKB0
  static const List<int> magicEncrypted = [0x47, 0x4B, 0x42, 0x31]; // GKB1
  static const int saltLength = 16;
  static const int nonceLength = 12;
  static const int macLength = 16;

  static Future<Result<Uint8List>> wrap({
    required Uint8List zipBytes,
    String? password,
  }) async {
    if (password == null || password.isEmpty) {
      return Success(
        Uint8List.fromList([...magicPlain, ...zipBytes]),
      );
    }
    try {
      final salt = _randomBytes(saltLength);
      final secretKey = await _deriveKey(password, salt);
      final algorithm = AesGcm.with256bits();
      final secretBox = await algorithm.encrypt(
        zipBytes,
        secretKey: secretKey,
      );
      final nonce = secretBox.nonce;
      final mac = secretBox.mac.bytes;
      return Success(
        Uint8List.fromList([
          ...magicEncrypted,
          ...salt,
          ...nonce,
          ...mac,
          ...secretBox.cipherText,
        ]),
      );
    } on Object catch (error) {
      return Failure(
        FileError(message: 'Failed to encrypt backup', cause: error),
      );
    }
  }

  static Future<Result<Uint8List>> unwrap({
    required Uint8List envelope,
    String? password,
  }) async {
    if (envelope.length < 4) {
      return const Failure(FileError(message: 'Corrupt backup file'));
    }
    final magic = envelope.sublist(0, 4);
    if (_equals(magic, magicPlain)) {
      return Success(Uint8List.sublistView(envelope, 4));
    }
    if (!_equals(magic, magicEncrypted)) {
      return const Failure(FileError(message: 'Unsupported backup format'));
    }
    if (password == null || password.isEmpty) {
      return const Failure(
        ValidationError(message: 'Password required for encrypted backup'),
      );
    }
    try {
      const header = 4 + saltLength + nonceLength + macLength;
      if (envelope.length <= header) {
        return const Failure(FileError(message: 'Corrupt encrypted backup'));
      }
      final salt = envelope.sublist(4, 4 + saltLength);
      final nonce =
          envelope.sublist(4 + saltLength, 4 + saltLength + nonceLength);
      final macBytes = envelope.sublist(
        4 + saltLength + nonceLength,
        header,
      );
      final cipherText = envelope.sublist(header);
      final secretKey = await _deriveKey(password, salt);
      final algorithm = AesGcm.with256bits();
      final clear = await algorithm.decrypt(
        SecretBox(cipherText, nonce: nonce, mac: Mac(macBytes)),
        secretKey: secretKey,
      );
      return Success(Uint8List.fromList(clear));
    } on SecretBoxAuthenticationError {
      return const Failure(
        ValidationError(message: 'Wrong backup password'),
      );
    } on Object catch (error) {
      return Failure(
        FileError(message: 'Failed to decrypt backup', cause: error),
      );
    }
  }

  static bool isEncrypted(Uint8List envelope) {
    if (envelope.length < 4) {
      return false;
    }
    return _equals(envelope.sublist(0, 4), magicEncrypted);
  }

  static Future<SecretKey> _deriveKey(String password, List<int> salt) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );
    return pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );
  }

  static Uint8List _randomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (_) => random.nextInt(256)),
    );
  }

  static bool _equals(List<int> a, List<int> b) {
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}
