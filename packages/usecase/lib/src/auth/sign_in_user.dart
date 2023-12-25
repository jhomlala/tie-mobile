import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class SignInUser {
  SignInUser({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<TieError, TieUser>> invoke({
    required String email,
    required String password,
  }) async {
    return authRepository.signIn(email: email, password: password);
  }
}
