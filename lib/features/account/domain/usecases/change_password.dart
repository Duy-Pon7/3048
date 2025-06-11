import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/account/domain/repositories/user_repository.dart';

class ChangePassword implements Usecase<String, ChangePassParam> {
  final UserRepository userRepository;

  ChangePassword({required this.userRepository});

  @override
  Future<Either<Failure, String>> call(ChangePassParam param) {
    return userRepository.changePassword(
      currentPass: param.currentPass,
      newPass: param.newPass,
      newPassConfirm: param.newPassConfirm,
    );
  }
}

class ChangePassParam {
  final String currentPass;
  final String newPass;
  final String newPassConfirm;

  ChangePassParam({
    required this.currentPass,
    required this.newPass,
    required this.newPassConfirm,
  });
}
