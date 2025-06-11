import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtp implements Usecase<String, VerifyOtpParams> {
  final AuthRepository authRepository;

  VerifyOtp({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(VerifyOtpParams param) async {
    return authRepository.verifyOtp(
      email: param.email,
      otp: param.otp,
    );
  }
}

class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams({required this.email, required this.otp});
}
