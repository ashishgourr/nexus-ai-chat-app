library;

import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt_pkg;

import '../error/exceptions.dart';
import '../services/storage/secure_storage_service.dart';

class EncryptionService {
  EncryptionService(this._secureStorage);

  final SecureStorageService _secureStorage;
  static const String _keyStorageKey = 'encryption_key';
  encrypt_pkg.Key? _key;
  encrypt_pkg.Encrypter? _encrypter;

  /// Initializes the encrypter with an existing or newly generated key.
  Future<void> initialize() async {
    final keyString = await _getOrCreateKey();
    _key = encrypt_pkg.Key.fromBase64(keyString);
    _encrypter = encrypt_pkg.Encrypter(
      encrypt_pkg.AES(_key!, mode: encrypt_pkg.AESMode.gcm),
    );
  }

  Future<String> _getOrCreateKey() async {
    final keyString = await _secureStorage.read(_keyStorageKey);
    if (keyString == null || keyString.isEmpty) {
      final key = encrypt_pkg.Key.fromSecureRandom(32);
      final keyStr = key.base64;
      await _secureStorage.write(_keyStorageKey, keyStr);
      return keyStr;
    }
    return keyString;
  }

  /// Encrypts [plainText] and returns 'iv:encrypted' base64 string.
  String encrypt(String plainText) {
    if (_encrypter == null) {
      throw const AppException('EncryptionService not initialized');
    }
    final iv = encrypt_pkg.IV.fromSecureRandom(16);
    final encrypted = _encrypter!.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  /// Decrypts [encryptedText] (format 'iv:encrypted').
  String decrypt(String encryptedText) {
    if (_encrypter == null) {
      throw const AppException('EncryptionService not initialized');
    }
    final parts = encryptedText.split(':');
    if (parts.length < 2) {
      throw const AppException('Invalid encrypted format');
    }
    final iv = encrypt_pkg.IV.fromBase64(parts[0]);
    final encrypted = encrypt_pkg.Encrypted.fromBase64(parts[1]);
    return _encrypter!.decrypt(encrypted, iv: iv);
  }

  /// Encrypts a JSON-serializable value (encodes to JSON first).
  String encryptJson(Object value) {
    return encrypt(jsonEncode(value));
  }

  /// Decrypts and decodes JSON to Object.
  Object decryptJson(String encryptedText) {
    return jsonDecode(decrypt(encryptedText)) as Object;
  }
}
