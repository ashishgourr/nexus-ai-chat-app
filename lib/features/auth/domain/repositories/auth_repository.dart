library;

import '../entities/user.dart';
import '../../../../core/error/failures.dart';

enum LinkProvider { google, apple }

abstract class AuthRepository {
  /// Returns current user or null if not signed in.
  Future<({Failure? failure, User? data})> getCurrentUser();

  /// Sign in anonymously (guest).
  Future<({Failure? failure, User? data})> signInAnonymous();

  /// Sign in with Google.
  Future<({Failure? failure, User? data})> signInWithGoogle();

  /// Sign in with Apple.
  Future<({Failure? failure, User? data})> signInWithApple();

  /// Link current anonymous user to Google/Apple without losing data.
  Future<({Failure? failure, User? data})> linkAnonymousAccount(
    LinkProvider provider,
  );

  /// Sign out.
  Future<({Failure? failure, void data})> signOut();
}
