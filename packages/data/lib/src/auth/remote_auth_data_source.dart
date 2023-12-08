import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<Either<TieError, bool>> signIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return const Right(true);
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
}
