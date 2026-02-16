library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialized() = AuthInitialized;
  const factory AuthEvent.signInAnonymousRequested() =
      AuthSignInAnonymousRequested;
  const factory AuthEvent.signInWithGoogleRequested() =
      AuthSignInWithGoogleRequested;
  const factory AuthEvent.signInWithAppleRequested() =
      AuthSignInWithAppleRequested;
  const factory AuthEvent.linkWithGoogleRequested() =
      AuthLinkWithGoogleRequested;
  const factory AuthEvent.linkWithAppleRequested() = AuthLinkWithAppleRequested;
  const factory AuthEvent.signOutRequested() = AuthSignOutRequested;
}
