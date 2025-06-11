import 'package:dartz/dartz.dart';
import 'package:work_flow/common/entities/user.dart';
import 'package:work_flow/core/errors/failure.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User?>> reviseInfo({
    required String fullname,
    required int gender,
    String? email,
    String? phone,
    String? birthday,
  });

  Future<Either<Failure, String>> changePassword({
    required String currentPass,
    required String newPass,
    required String newPassConfirm,
  });
}
