part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialise() = AuthInitialise;

  const factory AuthEvent.authenticate({
    required String email,
    required String password,
  }) = AuthAuthenticate;

  const factory AuthEvent.authStateChanged() = AuthStateChanged;

  const factory AuthEvent.signOut() = AuthSignOut;

  const factory AuthEvent.register({
    required String email,
    required String password,
  }) = AuthRegister;
}
