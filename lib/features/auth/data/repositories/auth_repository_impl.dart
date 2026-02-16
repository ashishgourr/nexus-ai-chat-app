library;

import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._remoteDataSource,
    this._firestore,
    FirebaseFirestore firebaseFirestore,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final FirebaseFirestore _firestore;

  @override
  Future<({Failure? failure, User? data})> getCurrentUser() async {
    try {
      final model = await _remoteDataSource.getCurrentUser();
      return (failure: null, data: model?.toEntity());
    } on AuthException catch (e) {
      AppLogger.w('AuthRepository getCurrentUser AuthException: ${e.message}');
      developer.log(
        'getCurrentUser AuthException',
        name: 'AuthRepository',
        error: e,
      );
      return (failure: AuthFailure(e.message), data: null);
    } catch (e, stackTrace) {
      AppLogger.e(
        'AuthRepository getCurrentUser failed',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'getCurrentUser',
        name: 'AuthRepository',
        error: e,
        stackTrace: stackTrace,
      );
      return (failure: AuthFailure(e.toString()), data: null);
    }
  }

  @override
  Future<({Failure? failure, User? data})> signInAnonymous() async {
    try {
      final model = await _remoteDataSource.signInAnonymous();
      return (failure: null, data: model.toEntity());
    } on AuthException catch (e) {
      AppLogger.w('AuthRepository signInAnonymous AuthException: ${e.message}');
      developer.log(
        'signInAnonymous AuthException',
        name: 'AuthRepository',
        error: e,
      );
      return (failure: AuthFailure(e.message), data: null);
    } catch (e, stackTrace) {
      AppLogger.e(
        'AuthRepository signInAnonymous failed',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'signInAnonymous',
        name: 'AuthRepository',
        error: e,
        stackTrace: stackTrace,
      );
      return (failure: AuthFailure(e.toString()), data: null);
    }
  }

  @override
  Future<({Failure? failure, User? data})> signInWithGoogle() async {
    try {
      final model = await _remoteDataSource.signInWithGoogle();
      return (failure: null, data: model.toEntity());
    } on AuthException catch (e) {
      AppLogger.w(
        'AuthRepository signInWithGoogle AuthException: ${e.message}',
      );
      developer.log(
        'signInWithGoogle AuthException',
        name: 'AuthRepository',
        error: e,
      );
      return (failure: AuthFailure(e.message), data: null);
    } catch (e, stackTrace) {
      AppLogger.e(
        'AuthRepository signInWithGoogle failed',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'signInWithGoogle',
        name: 'AuthRepository',
        error: e,
        stackTrace: stackTrace,
      );
      return (failure: AuthFailure(e.toString()), data: null);
    }
  }

  @override
  Future<({Failure? failure, User? data})> signInWithApple() async {
    try {
      final model = await _remoteDataSource.signInWithApple();
      return (failure: null, data: model.toEntity());
    } on AuthException catch (e) {
      AppLogger.w('AuthRepository signInWithApple AuthException: ${e.message}');
      developer.log(
        'signInWithApple AuthException',
        name: 'AuthRepository',
        error: e,
      );
      return (failure: AuthFailure(e.message), data: null);
    } catch (e, stackTrace) {
      AppLogger.e(
        'AuthRepository signInWithApple failed',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'signInWithApple',
        name: 'AuthRepository',
        error: e,
        stackTrace: stackTrace,
      );
      return (failure: AuthFailure(e.toString()), data: null);
    }
  }

  @override
  Future<({Failure? failure, User? data})> linkAnonymousAccount(
    LinkProvider provider,
  ) async {
    try {
      final oldUid = (await _remoteDataSource.getCurrentUser())?.id;
      final model = provider == LinkProvider.google
          ? await _remoteDataSource.linkWithGoogle()
          : await _remoteDataSource.linkWithApple();
      if (oldUid != null && oldUid != model.id) {
        await _migrateUserData(oldUid, model.id);
      }
      return (failure: null, data: model.toEntity());
    } on AuthException catch (e) {
      AppLogger.w(
        'AuthRepository linkAnonymousAccount AuthException: ${e.message}',
      );
      developer.log(
        'linkAnonymousAccount AuthException',
        name: 'AuthRepository',
        error: e,
      );
      return (failure: AuthFailure(e.message), data: null);
    } catch (e, stackTrace) {
      AppLogger.e(
        'AuthRepository linkAnonymousAccount failed',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'linkAnonymousAccount',
        name: 'AuthRepository',
        error: e,
        stackTrace: stackTrace,
      );
      return (failure: AuthFailure(e.toString()), data: null);
    }
  }

  Future<void> _migrateUserData(String oldUid, String newUid) async {
    try {
      final oldRef = _firestore.collection('users').doc(oldUid);
      final newRef = _firestore.collection('users').doc(newUid);
      final conversations = await oldRef.collection('conversations').get();
      for (final doc in conversations.docs) {
        final convData = doc.data();
        convData['ownerUid'] = newUid;
        final newConvRef = newRef.collection('conversations').doc(doc.id);
        await newConvRef.set(convData);
        final messages = await doc.reference.collection('messages').get();
        for (final msg in messages.docs) {
          await newConvRef.collection('messages').doc(msg.id).set(msg.data());
        }
      }
    } catch (_) {
      // Non-fatal: user is still linked
    }
  }

  @override
  Future<({Failure? failure, void data})> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return (failure: null, data: null);
    } on AuthException catch (e) {
      AppLogger.w('AuthRepository signOut AuthException: ${e.message}');
      developer.log('signOut AuthException', name: 'AuthRepository', error: e);
      return (failure: AuthFailure(e.message), data: null);
    } catch (e, stackTrace) {
      AppLogger.e(
        'AuthRepository signOut failed',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log(
        'signOut',
        name: 'AuthRepository',
        error: e,
        stackTrace: stackTrace,
      );
      return (failure: AuthFailure(e.toString()), data: null);
    }
  }
}
