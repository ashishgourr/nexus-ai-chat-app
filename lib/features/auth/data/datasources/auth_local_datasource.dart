library;

abstract class AuthLocalDataSource {
  Future<void> saveAnonymousUid(String uid);
  Future<String?> getAnonymousUid();
  Future<void> clearAnonymousUid();
}
