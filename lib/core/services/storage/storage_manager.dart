library;

import 'encrypted_storage_service.dart';
import 'local_storage_service.dart';
import 'secure_storage_service.dart';

class StorageManager {
  StorageManager(
    this._localStorage,
    this._secureStorage,
    this._encryptedStorage,
  );

  final LocalStorageService _localStorage;
  final SecureStorageService _secureStorage;
  final EncryptedStorageService _encryptedStorage;

  /// Unencrypted preferences (theme, language, etc.).
  Future<void> savePreference(String key, dynamic value) async {
    await _localStorage.save(key, value);
  }

  Future<T?> getPreference<T>(String key) async {
    return _localStorage.get<T>(key);
  }

  /// Platform-encrypted (Keychain/KeyStore) for tokens and IDs.
  Future<void> saveSecure(String key, String value) async {
    await _secureStorage.write(key, value);
  }

  Future<String?> getSecure(String key) async {
    return _secureStorage.read(key);
  }

  /// AES-256-GCM encrypted for sensitive user data.
  Future<void> saveEncrypted(String key, dynamic value) async {
    await _encryptedStorage.saveEncrypted(key, value);
  }

  Future<String?> getEncrypted(String key) async {
    return _encryptedStorage.getDecrypted(key);
  }

  Future<bool> removePreference(String key) async {
    return _localStorage.remove(key);
  }

  Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key);
  }
}
