part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthInitial {}

final class AuthFailure extends AuthInitial {
  final String message;

  AuthFailure({required this.message});
}

final class AuthMessageSuccess extends AuthInitial {
  final String message;

  AuthMessageSuccess({required this.message});
}

final class AuthUserSuccess extends AuthInitial {
  final User? user;

  AuthUserSuccess({required this.user});
}

final class AuthSuccess extends AuthInitial {}
