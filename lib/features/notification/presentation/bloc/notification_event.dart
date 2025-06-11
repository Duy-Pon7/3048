part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

final class NotificationGetList extends NotificationEvent {
  final int page;

  NotificationGetList({required this.page});
}
