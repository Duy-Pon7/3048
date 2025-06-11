import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/errors/server_exception.dart';
import 'package:work_flow/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:work_flow/features/notification/domain/entities/notification.dart';
import 'package:work_flow/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource notificationRemoteDatasource;

  NotificationRepositoryImpl({required this.notificationRemoteDatasource});

  @override
  Future<Either<Failure, List<Notification>>> getNotifications({
    required int page,
  }) async {
    try {
      final notifications = await notificationRemoteDatasource.getNotifications(
        page: page,
      );
      return Right(notifications);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
