import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class AuthRepository {
  AuthRepository({required this.remoteAuthDataSource});

  final AuthDataSource remoteAuthDataSource;

  Stream<bool> getAuthChangesStream() {
    return remoteAuthDataSource.getAuthChangesStream();
  }

  bool isAuthenticated() {
    return remoteAuthDataSource.isAuthenticated();
  }

  Future<Either<TieError, bool>> signIn({
    required String email,
    required String password,
  }) {
    return remoteAuthDataSource.signIn(email: email, password: password);
  }

  Future<Either<TieError, bool>> signOut() {
    return remoteAuthDataSource.signOut();
  }

  Future<Either<TieError, bool>> register({
    required String email,
    required String password,
  }) {
    return remoteAuthDataSource.register(email: email, password: password);
  }
}
