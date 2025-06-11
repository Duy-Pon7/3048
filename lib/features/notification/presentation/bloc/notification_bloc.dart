import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:work_flow/features/notification/domain/entities/notification.dart';
import 'package:work_flow/features/notification/domain/usecases/get_notifications.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc
    extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications _getNotifications;

  NotificationBloc({required GetNotifications getNotifications})
      : _getNotifications = getNotifications,
        super(NotificationInitial()) {
    on<NotificationEvent>(
        (event, emit) => emit(NotificationLoading()));
    on<NotificationGetList>(_onNotificationGetList);
  }
  //first
  void _onNotificationGetList(
    NotificationGetList event,
    Emitter<NotificationState> emit,
  ) async {
    final res = await _getNotifications.call(event.page);

    res.fold(
      (failure) =>
          emit(NotificationFailure(message: failure.message)),
      (notifications) {
        log(notifications.toString());
        emit(
          NotificationSuccess(
            page: event.page + 1,
            notifications: notifications,
          ),
        );
      },
    );
  }
}
