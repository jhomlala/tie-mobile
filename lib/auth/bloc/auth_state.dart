part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isLoading,
    required bool isAuthenticated,
    required bool authFailed,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(
    isLoading: true,
    isAuthenticated: false,
      authFailed: false,
  );
}
