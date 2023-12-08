import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class AuthDataSource {
  Future<Either<TieError, bool>> signIn();
  Future<Either<TieError, bool>> signOut();
  bool isAuthenticated();
  Stream<bool> getAuthChangesStream();
}
