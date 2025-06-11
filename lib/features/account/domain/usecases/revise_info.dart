import 'package:dartz/dartz.dart';
import 'package:work_flow/common/entities/user.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/account/domain/repositories/user_repository.dart';

class ReviseInfo implements Usecase<User?, ReviseInfoParam> {
  final UserRepository userRepository;

  ReviseInfo({required this.userRepository});
  @override
  Future<Either<Failure, User?>> call(ReviseInfoParam param) async {
    return await userRepository.reviseInfo(
      fullname: param.fullname,
      gender: param.gender,
      birthday: param.birthday,
      email: param.email,
      phone: param.phone,
    );
  }
}

class ReviseInfoParam {
  final String fullname;
  final int gender;
  final String? email;
  final String? phone;
  final String? birthday;

  ReviseInfoParam({
    required this.fullname,
    required this.gender,
    required this.email,
    required this.phone,
    required this.birthday,
  });
}
