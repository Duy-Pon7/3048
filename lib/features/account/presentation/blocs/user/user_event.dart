part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserReviseInfo extends UserEvent {
  final String fullname;
  final int gender;
  final String? email;
  final String? phone;
  final String? birthday;

  UserReviseInfo({
    required this.fullname,
    required this.gender,
    required this.email,
    required this.phone,
    required this.birthday,
  });
}

final class UserChangePass extends UserEvent {
  final String currentPass;
  final String newPass;
  final String newPassConfirm;

  UserChangePass({
    required this.currentPass,
    required this.newPass,
    required this.newPassConfirm,
  });
}
