import 'dart:async';

import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthInitialise>(_onInitialise);
    on<AuthAuthenticate>(_onAuthenticate);
    on<AuthStateChanged>(_onAuthStateChanged);
    on<AuthSignOut>(_onAuthSignOut);
  }

  late StreamSubscription<User?> _authStateSubscription;

  bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  FutureOr<void> _onInitialise(AuthInitialise event, Emitter<AuthState> emit) {
    _authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      add(const AuthEvent.authStateChanged());
    });
    emit(state.copyWith(isLoading: false, isAuthenticated: isAuthenticated()));
  }

  FutureOr<void> _onAuthenticate(
      AuthAuthenticate event, Emitter<AuthState> emit) async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(state.copyWith(isAuthenticated: true));
    } catch (error) {
      Log.error(error.toString());
      emit(state.copyWith(
        isAuthenticated: false,
        authFailed: true,
      ),);
    }
  }

  FutureOr<void> _onAuthStateChanged(
      AuthStateChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(isAuthenticated: isAuthenticated()));
  }

  FutureOr<void> _onAuthSignOut(
      AuthSignOut event, Emitter<AuthState> emit) async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
