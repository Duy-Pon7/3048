import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/auth/domain/repositories/auth_repository.dart';

class Login implements Usecase<String, LoginParams> {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(LoginParams param) async {
    return await authRepository.login(
      email: param.email,
      password: param.password,
      isSaveToken: param.isSaveToken,
    );
  }
}

class LoginParams {
  final String email;
  final String password;
  final bool isSaveToken;

  LoginParams({
    required this.email,
    required this.password,
    required this.isSaveToken,
  });
}
