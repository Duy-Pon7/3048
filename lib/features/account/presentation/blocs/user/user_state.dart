part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final User? user;
  final String? message;

  UserSuccess({
    this.user,
    this.message,
  });
}

final class UserFailure extends UserState {
  final String message;

  UserFailure({required this.message});
}
