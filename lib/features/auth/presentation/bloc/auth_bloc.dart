library;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/link_anonymous_account.dart';
import '../../domain/usecases/sign_in_anonymous.dart';
import '../../domain/usecases/sign_in_with_apple.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required GetCurrentUser getCurrentUser,
    required SignInAnonymous signInAnonymous,
    required SignInWithGoogle signInWithGoogle,
    required SignInWithApple signInWithApple,
    required LinkAnonymousAccount linkAnonymousAccount,
    required SignOut signOut,
  }) : _getCurrentUser = getCurrentUser,
       _signInAnonymous = signInAnonymous,
       _signInWithGoogle = signInWithGoogle,
       _signInWithApple = signInWithApple,
       _linkAnonymousAccount = linkAnonymousAccount,
       _signOut = signOut,
       super(const AuthState.initial()) {
    on<AuthInitialized>(_onInitialized);
    on<AuthSignInAnonymousRequested>(_onSignInAnonymous);
    on<AuthSignInWithGoogleRequested>(_onSignInWithGoogle);
    on<AuthSignInWithAppleRequested>(_onSignInWithApple);
    on<AuthLinkWithGoogleRequested>(_onLinkWithGoogle);
    on<AuthLinkWithAppleRequested>(_onLinkWithApple);
    on<AuthSignOutRequested>(_onSignOut);
  }

  final GetCurrentUser _getCurrentUser;
  final SignInAnonymous _signInAnonymous;
  final SignInWithGoogle _signInWithGoogle;
  final SignInWithApple _signInWithApple;
  final LinkAnonymousAccount _linkAnonymousAccount;
  final SignOut _signOut;

  Future<void> _onInitialized(
    AuthInitialized event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _getCurrentUser(NoParams());
    if (result.failure != null) {
      emit(AuthState.error(result.failure!.message));
      emit(const AuthState.unauthenticated());
      return;
    }
    if (result.data != null) {
      emit(AuthState.authenticated(result.data!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignInAnonymous(
    AuthSignInAnonymousRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signInAnonymous(NoParams());
    if (result.failure != null) {
      emit(AuthState.error(result.failure!.message));
      emit(const AuthState.unauthenticated());
      return;
    }
    if (result.data != null) {
      emit(AuthState.authenticated(result.data!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignInWithGoogle(
    AuthSignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signInWithGoogle(NoParams());
    _emitAuthResult(emit, result);
  }

  Future<void> _onSignInWithApple(
    AuthSignInWithAppleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signInWithApple(NoParams());
    _emitAuthResult(emit, result);
  }

  Future<void> _onLinkWithGoogle(
    AuthLinkWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _linkAnonymousAccount(LinkProvider.google);
    _emitAuthResult(emit, result);
  }

  Future<void> _onLinkWithApple(
    AuthLinkWithAppleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _linkAnonymousAccount(LinkProvider.apple);
    _emitAuthResult(emit, result);
  }

  void _emitAuthResult(
    Emitter<AuthState> emit,
    ({Failure? failure, User? data}) result,
  ) {
    if (result.failure != null) {
      final wasAuthenticated = state is AuthAuthenticated;
      final previousUser = wasAuthenticated
          ? (state as AuthAuthenticated).user
          : null;
      emit(AuthState.error(result.failure!.message));
      if (previousUser != null) {
        scheduleMicrotask(() => emit(AuthState.authenticated(previousUser)));
      } else {
        emit(const AuthState.unauthenticated());
      }
      return;
    }
    if (result.data != null) {
      emit(AuthState.authenticated(result.data!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signOut(NoParams());
    if (result.failure != null) {
      emit(AuthState.error(result.failure!.message));
    }
    emit(const AuthState.unauthenticated());
  }
}
