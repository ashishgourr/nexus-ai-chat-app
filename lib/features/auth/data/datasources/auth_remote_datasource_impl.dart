library;

import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/user_model.dart';
import 'auth_local_datasource.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(
    this._auth,
    this._localDataSource,
    AuthLocalDataSource authLocalDataSource, {
    GoogleSignIn? googleSignIn,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _auth;
  final AuthLocalDataSource _localDataSource;
  final GoogleSignIn _googleSignIn;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;
      return _userModelFromFirebase(user);
    } catch (e, stackTrace) {
      AppLogger.e('getCurrentUser failed', error: e, stackTrace: stackTrace);
      developer.log(
        'getCurrentUser',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  static bool _isPigeonDecodeError(Object e) {
    final msg = e.toString();
    return msg.contains('PigeonUserDetails') ||
        msg.contains('PigeonUserCredential') ||
        msg.contains("List<Object?>");
  }

  @override
  Future<UserModel> signInAnonymous() async {
    try {
      await _auth.signInAnonymously();
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        throw const AuthException(AppStrings.anonymousSignInNoUser);
      }
      if (firebaseUser.uid.isNotEmpty) {
        await _localDataSource.saveAnonymousUid(firebaseUser.uid);
      }
      return _userModelFromFirebase(firebaseUser);
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.e('signInAnonymous failed', error: e, stackTrace: stackTrace);
      developer.log(
        'signInAnonymous FirebaseAuthException',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      if (e.code == 'admin-restricted-operation' ||
          e.code == 'auth/admin-restricted-operation') {
        throw const AuthException(AppStrings.guestSignInNotEnabled);
      }
      throw AuthException(e.message ?? e.code);
    } catch (e, stackTrace) {
      AppLogger.e('signInAnonymous failed', error: e, stackTrace: stackTrace);
      developer.log(
        'signInAnonymous',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      final msg = e.toString();
      if (_isPigeonDecodeError(e)) {
        // Decode failed but native sign-in often succeeded; Dart currentUser
        // may not be set because the platform call threw. Wait for auth state.
        User? firebaseUser = _auth.currentUser;
        if (firebaseUser == null) {
          try {
            firebaseUser = await _auth
                .authStateChanges()
                .where((User? u) => u != null)
                .map((User? u) => u!)
                .first
                .timeout(const Duration(seconds: 3));
          } catch (_) {
            firebaseUser = _auth.currentUser;
          }
        }
        if (firebaseUser != null) {
          if (firebaseUser.uid.isNotEmpty) {
            await _localDataSource.saveAnonymousUid(firebaseUser.uid);
          }
          return _userModelFromFirebase(firebaseUser);
        }
      }
      if (msg.contains('admin-restricted') ||
          msg.contains('restricted to administrators')) {
        throw const AuthException(AppStrings.guestSignInNotEnabled);
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(AppStrings.googleSignInCancelled);
      }
      GoogleSignInAuthentication googleAuth;
      try {
        googleAuth = await googleUser.authentication;
      } catch (e, stackTrace) {
        AppLogger.e(
          'signInWithGoogle: googleUser.authentication failed',
          error: e,
          stackTrace: stackTrace,
        );
        developer.log(
          'signInWithGoogle googleUser.authentication',
          name: 'Auth',
          error: e,
          stackTrace: stackTrace,
        );
        // PigeonUserDetails / List<Object?> cast bug in google_sign_in on some platforms
        if (e.toString().contains('PigeonUserDetails') ||
            e.toString().contains('List<Object?>')) {
          throw AuthException(AppStrings.googleSignInCompatibility);
        }
        rethrow;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final currentUser = _auth.currentUser;
      try {
        if (currentUser != null && currentUser.isAnonymous) {
          await currentUser.linkWithCredential(credential);
        } else {
          await _auth.signInWithCredential(credential);
        }
      } catch (e, stackTrace) {
        // Firebase Auth platform returns UserCredential in a format that fails
        // PigeonUserCredential.decode (List<Object?> vs PigeonUserDetails). Sign-in
        // has already succeeded on native side — use currentUser instead.
        final isPigeonDecodeError =
            e.toString().contains('PigeonUserDetails') ||
            e.toString().contains('List<Object?>') ||
            e.toString().contains('PigeonUserCredential');
        if (isPigeonDecodeError) {
          AppLogger.w(
            'signInWithGoogle: ignoring Pigeon decode error (sign-in succeeded on native)',
            error: e,
            stackTrace: stackTrace,
          );
          developer.log(
            'signInWithGoogle Pigeon decode workaround',
            name: 'Auth',
            error: e,
            stackTrace: stackTrace,
          );
        } else {
          AppLogger.e(
            'signInWithGoogle signInWithCredential failed',
            error: e,
            stackTrace: stackTrace,
          );
          developer.log(
            'signInWithGoogle signInWithCredential',
            name: 'Auth',
            error: e,
            stackTrace: stackTrace,
          );
          rethrow;
        }
      }
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthException(AppStrings.googleSignInNoUser);
      }
      return _userModelFromFirebase(user);
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.e(
        'signInWithGoogle FirebaseAuthException',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'signInWithGoogle FirebaseAuthException',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException(e.message ?? e.code);
    } catch (e, stackTrace) {
      AppLogger.e('signInWithGoogle failed', error: e, stackTrace: stackTrace);
      developer.log(
        'signInWithGoogle',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      if (e.toString().contains('PigeonUserDetails') ||
          e.toString().contains('List<Object?>') ||
          e.toString().contains('subtype')) {
        throw AuthException(
          AppStrings.googleSignInFailed,
        );
      }
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    try {
      final appleCred = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCred = OAuthProvider('apple.com').credential(
        idToken: appleCred.identityToken,
        accessToken: appleCred.authorizationCode,
      );
      final currentUser = _auth.currentUser;
      try {
        if (currentUser != null && currentUser.isAnonymous) {
          await currentUser.linkWithCredential(oauthCred);
        } else {
          await _auth.signInWithCredential(oauthCred);
        }
      } catch (e, stackTrace) {
        final isPigeonDecodeError =
            e.toString().contains('PigeonUserDetails') ||
            e.toString().contains('List<Object?>') ||
            e.toString().contains('PigeonUserCredential');
        if (isPigeonDecodeError) {
          AppLogger.w(
            'signInWithApple: ignoring Pigeon decode error (sign-in succeeded on native)',
            error: e,
            stackTrace: stackTrace,
          );
        } else {
          rethrow;
        }
      }
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthException(AppStrings.appleSignInNoUser);
      }
      return _userModelFromFirebase(user);
    } on SignInWithAppleAuthorizationException catch (e) {
      // Error 1000 / unknown: typically means Sign in with Apple is not configured
      // (no Apple Developer account or capability not enabled). See docs/APPLE_SIGNIN_SETUP.md.
      if (e.code == AuthorizationErrorCode.unknown ||
          (e.message.contains('1000') || e.message.contains('couldn\'t be completed'))) {
        throw const AuthException(AppStrings.appleSignInSetupRequired);
      }
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const AuthException(AppStrings.appleSignInCancelled);
      }
      throw AuthException(e.message);
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.e(
        'signInWithApple FirebaseAuthException',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'signInWithApple FirebaseAuthException',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException(e.message ?? e.code);
    } catch (e, stackTrace) {
      AppLogger.e('signInWithApple failed', error: e, stackTrace: stackTrace);
      developer.log(
        'signInWithApple',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<UserModel> linkWithGoogle() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null || !currentUser.isAnonymous) {
        throw const AuthException(AppStrings.notAnonymousUser);
      }
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(AppStrings.googleSignInCancelled);
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        await currentUser.linkWithCredential(credential);
      } catch (e, stackTrace) {
        final isPigeonDecodeError =
            e.toString().contains('PigeonUserDetails') ||
            e.toString().contains('List<Object?>') ||
            e.toString().contains('PigeonUserCredential');
        if (isPigeonDecodeError) {
          AppLogger.w(
            'linkWithGoogle: ignoring Pigeon decode error (link succeeded on native)',
            error: e,
            stackTrace: stackTrace,
          );
        } else {
          AppLogger.e(
            'linkWithGoogle linkWithCredential failed',
            error: e,
            stackTrace: stackTrace,
          );
          throw _linkCredentialAuthException(e, isGoogle: true);
        }
      }
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthException(AppStrings.linkReturnedNoUser);
      }
      return _userModelFromFirebase(user);
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw _linkCredentialAuthException(e, isGoogle: true);
    } catch (e, stackTrace) {
      AppLogger.e('linkWithGoogle failed', error: e, stackTrace: stackTrace);
      developer.log(
        'linkWithGoogle',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// User-friendly message for link credential errors (e.g. credential-already-in-use).
  static AuthException _linkCredentialAuthException(
    Object e, {
    required bool isGoogle,
  }) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'credential-already-in-use':
          return AuthException(
            isGoogle
                ? AppStrings.googleAccountAlreadyInUse
                : AppStrings.appleAccountAlreadyInUse,
          );
        case 'email-already-in-use':
          return AuthException(AppStrings.emailAlreadyLinked);
        case 'provider-already-linked':
          return AuthException(AppStrings.accountAlreadyLinked);
        default:
          return AuthException(e.message ?? e.code);
      }
    }
    return AuthException(e.toString());
  }

  @override
  Future<UserModel> linkWithApple() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null || !currentUser.isAnonymous) {
        throw const AuthException(AppStrings.notAnonymousUser);
      }
      final appleCred = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCred = OAuthProvider('apple.com').credential(
        idToken: appleCred.identityToken,
        accessToken: appleCred.authorizationCode,
      );
      try {
        await currentUser.linkWithCredential(oauthCred);
      } catch (e, stackTrace) {
        final isPigeonDecodeError =
            e.toString().contains('PigeonUserDetails') ||
            e.toString().contains('List<Object?>') ||
            e.toString().contains('PigeonUserCredential');
        if (isPigeonDecodeError) {
          AppLogger.w(
            'linkWithApple: ignoring Pigeon decode error (link succeeded on native)',
            error: e,
            stackTrace: stackTrace,
          );
        } else {
          throw _linkCredentialAuthException(e, isGoogle: false);
        }
      }
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthException(AppStrings.linkReturnedNoUser);
      }
      return _userModelFromFirebase(user);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.unknown ||
          (e.message.contains('1000') || e.message.contains('couldn\'t be completed'))) {
        throw const AuthException(AppStrings.appleLinkSetupRequired);
      }
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const AuthException(AppStrings.appleSignInCancelled);
      }
      throw AuthException(e.message);
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw _linkCredentialAuthException(e, isGoogle: false);
    } catch (e, stackTrace) {
      AppLogger.e('linkWithApple failed', error: e, stackTrace: stackTrace);
      developer.log(
        'linkWithApple',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await _localDataSource.clearAnonymousUid();
    } catch (e, stackTrace) {
      AppLogger.e('signOut failed', error: e, stackTrace: stackTrace);
      developer.log('signOut', name: 'Auth', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  UserModel _userModelFromFirebase(User user) {
    // Avoid reading provider data (email, displayName, photoURL) when it triggers
    // the PigeonUserDetails cast bug on some platforms; use uid + isAnonymous only
    // and safely read the rest to avoid type 'List<Object?>' is not a subtype of 'PigeonUserDetails?'.
    String? email;
    String? displayName;
    String? photoUrl;
    try {
      email = user.email;
    } catch (e, stackTrace) {
      AppLogger.w(
        'Auth: _userModelFromFirebase failed to read user.email (uid=${user.uid})',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        '_userModelFromFirebase user.email',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
    }
    try {
      displayName = user.displayName;
    } catch (e, stackTrace) {
      AppLogger.w(
        'Auth: _userModelFromFirebase failed to read user.displayName (uid=${user.uid})',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        '_userModelFromFirebase user.displayName',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
    }
    try {
      photoUrl = user.photoURL;
    } catch (e, stackTrace) {
      AppLogger.w(
        'Auth: _userModelFromFirebase failed to read user.photoURL (uid=${user.uid})',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        '_userModelFromFirebase user.photoURL',
        name: 'Auth',
        error: e,
        stackTrace: stackTrace,
      );
    }
    return UserModel(
      id: user.uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      isAnonymous: user.isAnonymous,
    );
  }
}
