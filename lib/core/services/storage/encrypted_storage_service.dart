library;

import 'dart:convert';

import '../../security/encryption_service.dart';
import 'local_storage_service.dart';

class EncryptedStorageService {
  EncryptedStorageService(this._encryption, this._localStorage);

  final EncryptionService _encryption;
  final LocalStorageService _localStorage;

  Future<void> saveEncrypted(String key, dynamic value) async {
    final encoded = value is String ? value : jsonEncode(value);
    final encrypted = _encryption.encrypt(encoded);
    await _localStorage.save(key, encrypted);
  }

  Future<String?> getDecrypted(String key) async {
    final stored = await _localStorage.get<String>(key);
    if (stored == null || stored.isEmpty) return null;
    return _encryption.decrypt(stored);
  }

  Future<Object?> getDecryptedJson(String key) async {
    final decrypted = await getDecrypted(key);
    if (decrypted == null) return null;
    return jsonDecode(decrypted) as Object;
  }

  Future<bool> remove(String key) async {
    return _localStorage.remove(key);
  }
}
