import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class RegisterUser {
  RegisterUser({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<TieError, bool>> invoke({
    required String email,
    required String password,
  }) async {
    return authRepository.register(email: email, password: password);
  }
}