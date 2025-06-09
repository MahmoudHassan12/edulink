part of 'registered_users_cubit.dart';

@immutable
sealed class RegisteredUsersState {
  const RegisteredUsersState();
}

final class RegisteredUsersInitial extends RegisteredUsersState {}

final class RegisteredUsersLoading extends RegisteredUsersState {}

final class RegisteredUsersSuccess extends RegisteredUsersState {
  const RegisteredUsersSuccess(this.users);
  final List<UserEntity>? users;
}

final class RegisteredUsersFailure extends RegisteredUsersState {
  const RegisteredUsersFailure(this.error);
  final String error;
}
