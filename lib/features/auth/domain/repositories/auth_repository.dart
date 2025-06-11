import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
    required bool isSaveToken,
  });

  Future<Either<Failure, User?>> signup({
    required String email,
    required String birthday,
    required int gender,
    required String fullname,
    required String password,
    required String passwordConfimation,
    required String phone,
  });

  Future<Either<Failure, String>> sendEmail({required String email});

  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, User?>> resetPassword({
    required String email,
    required String newPass,
    required String newPassConfirm,
  });

  Future<Either<Failure, User?>> getAuth();
}
