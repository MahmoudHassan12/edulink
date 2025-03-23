part of 'manage_profile_cubit.dart';

@immutable
sealed class ManageProfileState {
  const ManageProfileState();
}

final class ManageProfileInitial extends ManageProfileState {
  const ManageProfileInitial();
}

final class ManageProfileUpdated extends ManageProfileState {}

final class ManageProfileLoading extends ManageProfileState {
  const ManageProfileLoading();
}

final class ManageProfileSuccess extends ManageProfileState {
  const ManageProfileSuccess(this.user);
  final UserEntity user;
}

final class ManageProfileFailure extends ManageProfileState {
  const ManageProfileFailure(this.error);
  final String error;
}
