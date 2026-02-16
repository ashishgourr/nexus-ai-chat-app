library;

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInAnonymous();
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<UserModel> linkWithGoogle();
  Future<UserModel> linkWithApple();
  Future<void> signOut();
}
