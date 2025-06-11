import 'package:dio/dio.dart';
import 'package:work_flow/common/models/response_model.dart';
import 'package:work_flow/core/constants/api_urls.dart';
import 'package:work_flow/core/constants/app_errors.dart';
import 'package:work_flow/core/errors/server_exception.dart';
import 'package:work_flow/core/network/dio_client.dart';

import '../models/get_notifications_model.dart';
import '../models/notification_model.dart';

abstract interface class NotificationRemoteDatasource {
  Future<List<NotificationModel>> getNotifications({required int page});
}

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  final DioClient dioClient;

  NotificationRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<List<NotificationModel>> getNotifications({required int page}) async {
    try {
      final res = await dioClient.get(
        url: '${NotificationApiUrls.getNotifications}?page=$page',
      );
      if (res.statusCode == 200) {
        final returnedData = ResponseModel<GetNotificationsModel>.fromJson(
          res.data,
          (json) => GetNotificationsModel.fromJson(
            json as Map<String, dynamic>,
          ),
        );
        if (returnedData.data?.notifications == null) {
          return List.empty();
        }
        return returnedData.data!.notifications!;
      }
      throw ServerException(message: AppErrors.getNotificationsFailure);
    } on DioException catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
