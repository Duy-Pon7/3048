part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final int page;
  final List<Notification> notifications;

  NotificationSuccess({
    required this.page,
    required this.notifications,
  });
}

final class NotificationFailure extends NotificationState {
  final String message;

  NotificationFailure({required this.message});
}
