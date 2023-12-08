import 'dart:async';

import 'package:data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<AuthInitialise>(_onInitialise);
    on<AuthAuthenticate>(_onAuthenticate);
    on<AuthStateChanged>(_onAuthStateChanged);
    on<AuthSignOut>(_onAuthSignOut);
  }

  final AuthRepository authRepository;

  late StreamSubscription<bool> _authStateSubscription;

  bool isAuthenticated() {
    return authRepository.isAuthenticated();
  }

  FutureOr<void> _onInitialise(AuthInitialise event, Emitter<AuthState> emit) {
    _authStateSubscription =
        authRepository.getAuthChangesStream().listen((user) {
      add(const AuthEvent.authStateChanged());
    });
    emit(state.copyWith(isLoading: false, isAuthenticated: isAuthenticated()));
  }

  FutureOr<void> _onAuthenticate(
    AuthAuthenticate event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    (await authRepository.signIn()).fold((l) {
      emit(
        state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          authFailed: true,
        ),
      );
    }, (r) {
      emit(state.copyWith(isAuthenticated: true, isLoading: false));
    });
  }

  FutureOr<void> _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isAuthenticated: isAuthenticated()));
  }

  FutureOr<void> _onAuthSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signOut();
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
