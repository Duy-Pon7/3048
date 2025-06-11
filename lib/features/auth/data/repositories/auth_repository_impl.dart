import 'package:dartz/dartz.dart';
import 'package:work_flow/core/constants/app_errors.dart';
import 'package:work_flow/core/constants/app_successes.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/errors/server_exception.dart';
import 'package:work_flow/core/local/share_prefs_service.dart';
import 'package:work_flow/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:work_flow/common/models/user_model.dart';
import 'package:work_flow/common/entities/user.dart';
import 'package:work_flow/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final SharePrefsService sharePrefsService;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.sharePrefsService,
  });

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
    required bool isSaveToken,
  }) async {
    try {
      String? token = await authRemoteDatasource.login(
        email: email,
        password: password,
      );
      if (token == null) {
        return Left(Failure(message: AppErrors.failureLogin));
      }
      await sharePrefsService.saveAuthToken(token);
      if (isSaveToken) {
        await sharePrefsService.saveSession(isSaveToken);
      }
      return Right(AppSuccesses.successfullLogin);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signup({
    required String email,
    required String birthday,
    required int gender,
    required String fullname,
    required String password,
    required String passwordConfimation,
    required String phone,
  }) async {
    return await _getUser(
      () => authRemoteDatasource.signup(
        email: email,
        birthday: birthday,
        gender: gender,
        fullname: fullname,
        password: password,
        passwordConfimation: passwordConfimation,
        phone: phone,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> sendEmail({required String email}) async {
    try {
      final message = await authRemoteDatasource.sendEmail(email: email);
      return Right(message);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final message =
          await authRemoteDatasource.otpVerifyOtp(email: email, otp: otp);
      return Right(message);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> resetPassword({
    required String email,
    required String newPass,
    required String newPassConfirm,
  }) async {
    return await _getUser(
      () => authRemoteDatasource.resetPassword(
        email: email,
        newPass: newPass,
        newPassConfirm: newPassConfirm,
      ),
    );
  }

  @override
  Future<Either<Failure, User?>> getAuth() async {
    return await _getUser(authRemoteDatasource.getAuth);
  }

  Future<Either<Failure, User?>> _getUser(
    Future<UserModel?> Function() func,
  ) async {
    try {
      final UserModel? user = await func();
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
