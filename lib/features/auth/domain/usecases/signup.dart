import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/common/entities/user.dart';
import 'package:work_flow/features/auth/domain/repositories/auth_repository.dart';

class Signup implements Usecase<User?, SignupParams> {
  final AuthRepository authRepository;

  Signup({required this.authRepository});

  @override
  Future<Either<Failure, User?>> call(SignupParams param) async {
    return await authRepository.signup(
        email: param.email,
        birthday: param.birthday,
        gender: param.gender,
        fullname: param.fullname,
        password: param.password,
        passwordConfimation: param.passwordConfimation,
        phone: param.phone);
  }
}

class SignupParams {
  final String email;
  final String birthday;
  final int gender;
  final String fullname;
  final String password;
  final String passwordConfimation;
  final String phone;

  SignupParams(
      {required this.email,
      required this.birthday,
      required this.gender,
      required this.fullname,
      required this.password,
      required this.passwordConfimation,
      required this.phone});
}
