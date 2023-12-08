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

  Future<Either<TieError, bool>> signIn() {
    return remoteAuthDataSource.signIn();
  }

  Future<Either<TieError, bool>> signOut() {
    return remoteAuthDataSource.signOut();
  }
}
