part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialise() = AuthInitialise;
  const factory AuthEvent.authenticate() = AuthAuthenticate;
  const factory AuthEvent.authStateChanged() = AuthStateChanged;
  const factory AuthEvent.signOut() = AuthSignOut;
  const factory AuthEvent.register() = AuthRegister;
}
