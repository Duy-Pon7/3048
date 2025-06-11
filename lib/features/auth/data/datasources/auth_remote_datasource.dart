import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:work_flow/common/models/response_model.dart';
import 'package:work_flow/core/constants/api_urls.dart';
import 'package:work_flow/core/constants/app_errors.dart';
import 'package:work_flow/core/constants/app_successes.dart';
import 'package:work_flow/core/errors/server_exception.dart';
import 'package:work_flow/core/network/dio_client.dart';

import '../../../../common/models/user_model.dart';

abstract interface class AuthRemoteDatasource {
  Future<String?> login({
    required String email,
    required String password,
  });

  Future<UserModel?> signup({
    required String email,
    required String birthday,
    required int gender,
    required String fullname,
    required String password,
    required String passwordConfimation,
    required String phone,
  });

  Future<String> sendEmail({required String email});

  Future<String> otpVerifyOtp(
      {required String email, required String otp});

  Future<UserModel?> resetPassword({
    required String email,
    required String newPass,
    required String newPassConfirm,
  });

  Future<UserModel?> getAuth();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient dioClient;

  AuthRemoteDatasourceImpl({required this.dioClient});

  String _getErrorMessage(Map<String, dynamic> errors) {
    String mess = AppErrors.commonError;
    if (errors.containsKey('message_validate')) {
      final validates =
          errors['message_validate'] as Map<String, dynamic>;
      if (validates.containsKey('email')) {
        mess = validates['email'].first;
      } else if (validates.containsKey('password')) {
        print('ok');
        mess = validates['password'].first;
      } else if (validates.containsKey('birthday')) {
        mess = validates['birthday'].first;
      } else if (validates.containsKey('gender')) {
        mess = validates['gender'].first;
      } else if (validates.containsKey('fullname')) {
        mess = validates['fullname'].first;
      } else if (validates.containsKey('phone')) {
        mess = validates['phone'].first;
      } else if (validates.containsKey('otp')) {
        mess = validates['otp'].first;
      }
    } else if (errors.containsKey('message')) {
      mess = errors['message'] as String;
    }
    return mess;
  }

  @override
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dioClient.post(
        url: AuthApiUrls.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (res.statusCode == 200) {
        return res.data['access_token'] as String;
      }
      return null;
    } on DioException catch (e) {
      String mess = AppErrors.commonError;
      final errors = e.response?.data;
      if (errors != null) {
        mess = errors is Map<String, dynamic>
            ? _getErrorMessage(errors)
            : AppErrors.commonError;
      }
      throw ServerException(message: mess);
    }
  }

  @override
  Future<UserModel?> signup(
      {required String email,
      required String birthday,
      required int gender,
      required String fullname,
      required String password,
      required String passwordConfimation,
      required String phone}) async {
    return await _getUser(
      () => dioClient.post(
        url: AuthApiUrls.signup,
        data: {
          "email": email,
          "password": password,
          "password_confirmation": passwordConfimation,
          "fullname": fullname,
          "birthday": birthday,
          "gender": gender,
          "phone": phone,
        },
      ),
    );
  }

  @override
  Future<String> sendEmail({required String email}) async {
    try {
      final res =
          await dioClient.post(url: AuthApiUrls.sendEmail, data: {
        "type": "email",
        "value": email,
      });
      if (res.statusCode == 200) {
        return AppSuccesses.successfullSendEmail;
      }
      return AppErrors.failureSendEmail;
    } on DioException catch (e) {
      String mess = AppErrors.commonError;
      final errors = e.response?.data;
      if (errors != null) {
        mess = errors is Map<String, dynamic>
            ? _getErrorMessage(errors)
            : AppErrors.commonError;
      }
      throw ServerException(message: mess);
    }
  }

  @override
  Future<String> otpVerifyOtp(
      {required String email, required String otp}) async {
    try {
      final res =
          await dioClient.post(url: AuthApiUrls.verifyOtp, data: {
        "value": email,
        "type": "email",
        "otp": otp,
      });

      if (res.statusCode == 200) {
        return AppSuccesses.successfullSendEmail;
      }
      return AppErrors.failureSendEmail;
    } on DioException catch (e) {
      String mess = AppErrors.commonError;
      final errors = e.response?.data;
      if (errors != null) {
        mess = errors is Map<String, dynamic>
            ? _getErrorMessage(errors)
            : AppErrors.commonError;
      }
      throw ServerException(message: mess);
    }
  }

  @override
  Future<UserModel?> resetPassword({
    required String email,
    required String newPass,
    required String newPassConfirm,
  }) async {
    return await _getUser(
      () => dioClient.put(
        url: AuthApiUrls.resetPassword,
        data: {
          "type": "email",
          "value": email,
          "password": newPass,
          "password_confirmation": newPassConfirm,
        },
      ),
    );
  }

  @override
  Future<UserModel?> getAuth() async {
    return await _getUser(
      () => dioClient.get(url: AuthApiUrls.getAuth),
    );
  }

  Future<UserModel?> _getUser(
    Future<Response<dynamic>> Function() func,
  ) async {
    try {
      final res = await func();
      if (res.statusCode == 200) {
        final returnedData = ResponseModel<UserModel>.fromJson(
          res.data,
          (json) => UserModel.fromJson(
            json as Map<String, dynamic>,
          ),
        );
        if (returnedData.data == null) {
          return null;
        }
        log(returnedData.data.toString());
        return returnedData.data!;
      }
      throw ServerException(message: AppErrors.getAuthFailure);
    } on DioException catch (e) {
      String mess = AppErrors.commonError;
      final errors = e.response?.data;
      if (errors != null) {
        mess = errors is Map<String, dynamic>
            ? _getErrorMessage(errors)
            : AppErrors.commonError;
      }
      throw ServerException(message: mess);
    }
  }
}
