import 'notification_model.dart';

class GetNotificationsModel {
  final List<NotificationModel>? notifications;

  GetNotificationsModel({
    required this.notifications,
  });

  factory GetNotificationsModel.fromJson(Map<String, dynamic> json) =>
      GetNotificationsModel(
        notifications: json['notification'] == null
            ? []
            : List<NotificationModel>.from(
                (json['notification'] as List<dynamic>).map(
                  (el) => NotificationModel.fromMap(el),
                ),
              ),
      );
}
