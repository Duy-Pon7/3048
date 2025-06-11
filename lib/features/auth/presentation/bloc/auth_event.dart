part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final bool isSaveToken;

  AuthLogin({
    required this.email,
    required this.password,
    required this.isSaveToken,
  });
}

final class AuthSignup extends AuthEvent {
  final String email;
  final String birthday;
  final int gender;
  final String fullname;
  final String password;
  final String passwordConfimation;
  final String phone;

  AuthSignup(
      {required this.email,
      required this.birthday,
      required this.gender,
      required this.fullname,
      required this.password,
      required this.passwordConfimation,
      required this.phone});
}

final class AuthSendEmail extends AuthEvent {
  final String email;

  AuthSendEmail({required this.email});
}

final class AuthVerifyOtp extends AuthEvent {
  final String email;
  final String otp;

  AuthVerifyOtp({required this.email, required this.otp});
}

final class AuthResetPassword extends AuthEvent {
  final String email;
  final String newPass;
  final String newPassConfirm;

  AuthResetPassword({
    required this.email,
    required this.newPass,
    required this.newPassConfirm,
  });
}

final class AuthGetSession extends AuthEvent {}

final class AuthUpdateSession extends AuthEvent {
  final User? user;

  AuthUpdateSession({this.user});
}
