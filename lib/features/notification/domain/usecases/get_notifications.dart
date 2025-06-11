import 'package:dartz/dartz.dart';
import 'package:work_flow/core/errors/failure.dart';
import 'package:work_flow/core/usecase/usecase.dart';
import 'package:work_flow/features/notification/domain/repositories/notification_repository.dart';

import '../entities/notification.dart';

class GetNotifications implements Usecase<List<Notification>, int> {
  final NotificationRepository notificationRepository;

  GetNotifications({required this.notificationRepository});

  @override
  Future<Either<Failure, List<Notification>>> call(int param) async {
    return await notificationRepository.getNotifications(page: param);
  }
}
