library;

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage/storage_manager.dart';
import 'auth_local_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._storage);

  final StorageManager _storage;

  @override
  Future<void> saveAnonymousUid(String uid) async {
    await _storage.saveSecure(StorageKeys.anonymousUid, uid);
  }

  @override
  Future<String?> getAnonymousUid() async {
    return _storage.getSecure(StorageKeys.anonymousUid);
  }

  @override
  Future<void> clearAnonymousUid() async {
    await _storage.removeSecure(StorageKeys.anonymousUid);
  }
}
