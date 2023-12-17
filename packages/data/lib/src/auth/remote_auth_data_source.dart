import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteAuthDataSource extends AuthDataSource {
  @override
  Stream<bool> getAuthChangesStream() {
    return _getFirebaseAuth().authStateChanges().map((user) => user != null);
  }

  @override
  bool isAuthenticated() {
    return _getFirebaseAuth().currentUser != null;
  }

  @override
  Future<Either<TieError, bool>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _getFirebaseAuth()
          .signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        return const Right(true);
      } else {
        return Left(TieAuthError('Invalid email/password'));
      }
    } catch (error) {
      Log.error(error.toString());
      return Left(TieAuthError(error.toString()));
    }
  }

  @override
  Future<Either<TieError, bool>> signOut() async {
    try {
      await _getFirebaseAuth().signOut();
      return const Right(true);
    } catch (error) {
      Log.error(error.toString());
      return Left(TieAuthError(error.toString()));
    }
  }

  FirebaseAuth _getFirebaseAuth() {
    return FirebaseAuth.instance;
  }

  @override
  Future<Either<TieError, bool>> register({
    required String email,
    required String password,
  }) async {
    try {
      await _getFirebaseAuth()
          .createUserWithEmailAndPassword(email: email, password: password);
      return const Right(true);
    } catch (error) {
      Log.error(error.toString());
      return Left(TieAuthError(error.toString()));
    }
  }
}
