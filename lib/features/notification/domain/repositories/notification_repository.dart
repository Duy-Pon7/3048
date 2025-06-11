import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';

import '../entities/notification.dart';

abstract interface class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications({
    required int page,
  });
}
