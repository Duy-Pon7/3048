import 'package:dartz/dartz.dart';
import 'package:work_flow/common/entities/user.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/errors/server_exception.dart';
import 'package:work_flow/features/account/data/datasources/user_remote_datasource.dart';
import 'package:work_flow/features/account/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, User?>> reviseInfo({
    required String fullname,
    required int gender,
    String? email,
    String? phone,
    String? birthday,
  }) async {
    try {
      final user = await userRemoteDatasource.reviseInfo(
        fullname: fullname,
        gender: gender,
        birthday: birthday,
        email: email,
        phone: phone,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String currentPass,
    required String newPass,
    required String newPassConfirm,
  }) async {
    try {
      final String message =
          await userRemoteDatasource.changePassword(
        currentPass: currentPass,
        newPass: newPass,
        newPassConfirm: newPassConfirm,
      );
      return Right(message);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
