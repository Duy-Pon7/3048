import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/auth/domain/repositories/auth_repository.dart';

class SendEmail implements Usecase<String, String> {
  final AuthRepository authRepository;

  SendEmail({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(String param) async {
    return await authRepository.sendEmail(email: param);
  }
}
