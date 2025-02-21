part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  const AuthSuccess(this.professorEntity);
  final ProfessorEntity professorEntity;
}

final class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
}

final class AuthUpdated extends AuthState {}
