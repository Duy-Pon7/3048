import 'package:dio/dio.dart';
import 'package:work_flow/common/models/response_model.dart';
import 'package:work_flow/common/models/user_model.dart';
import 'package:work_flow/core/constants/api_urls.dart';
import 'package:work_flow/core/constants/app_errors.dart';
import 'package:work_flow/core/errors/server_exception.dart';
import 'package:work_flow/core/network/dio_client.dart';

abstract interface class UserRemoteDatasource {
  Future<UserModel?> reviseInfo({
    required String fullname,
    required int gender,
    String? email,
    String? phone,
    String? birthday,
  });

  Future<String> changePassword({
    required String currentPass,
    required String newPass,
    required String newPassConfirm,
  });
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final DioClient dioClient;

  UserRemoteDatasourceImpl({required this.dioClient});

  String _getErrorMessage(Map<String, dynamic> errors) {
    String message = AppErrors.commonError;
    if (errors.containsKey('message_validate')) {
      final validates =
          errors['message_validate'] as Map<String, dynamic>;
      if (validates.containsKey('fullname')) {
        message = validates['fullname'].first;
      } else if (validates.containsKey('gender')) {
        message = validates['gender'].first;
      } else if (validates.containsKey('old_password')) {
        message = validates['old_password'].first;
      } else if (validates.containsKey('password')) {
        message = validates['password'].first;
      }
    } else if (errors.containsKey('message')) {
      message = errors['message'];
    }
    return message;
  }

  @override
  Future<UserModel?> reviseInfo({
    required String fullname,
    required int gender,
    String? email,
    String? phone,
    String? birthday,
  }) async {
    try {
      final res = await dioClient.post(
        url: UserApiUrls.reviseInfo,
        data: {
          "email": email,
          "fullname": fullname,
          "phone": phone,
          "gender": gender,
          "birthday": birthday,
        },
      );
      if (res.statusCode == 200) {
        final returnedData = ResponseModel<UserModel>.fromJson(
          res.data,
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );
        if (returnedData.data == null) {
          return null;
        }
        return returnedData.data!;
      }
      throw ServerException(message: AppErrors.reviseInfoFailure);
    } on DioException catch (e) {
      String message = AppErrors.commonError;
      final errors = e.response?.data;
      if (errors != null && errors is Map<String, dynamic>) {
        message = _getErrorMessage(errors);
      }
      throw ServerException(message: message);
    }
  }

  @override
  Future<String> changePassword({
    required String currentPass,
    required String newPass,
    required String newPassConfirm,
  }) async {
    try {
      final res = await dioClient.put(
        url: UserApiUrls.chanegPassword,
        data: {
          "old_password": currentPass,
          "password": newPass,
          "password_confirmation": newPassConfirm,
        },
      );
      if (res.statusCode == 200) {
        final returnedData =
            ResponseModel.fromJson(res.data, (json) => null);
        if (returnedData.message == null) {
          return AppErrors.commonError;
        }
        return returnedData.message!;
      }
      throw ServerException(message: AppErrors.changePassFailure);
    } on DioException catch (e) {
      String message = AppErrors.commonError;
      final errors = e.response?.data;
      if (errors != null && errors is Map<String, dynamic>) {
        message = _getErrorMessage(errors);
      }
      throw ServerException(message: message);
    }
  }
}
