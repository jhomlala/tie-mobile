import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class AuthDataSource {
  Future<Either<TieError, bool>> signIn({
    required String email,
    required String password,
  });

  Future<Either<TieError, bool>> signOut();

  Future<Either<TieError, bool>> register({
    required String email,
    required String password,
  });

  bool isAuthenticated();

  Stream<bool> getAuthChangesStream();
}
