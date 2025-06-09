part of 'manage_course_cubit.dart';

@immutable
sealed class ManageCourseState {
  const ManageCourseState();
}

final class ManageCourseInitial extends ManageCourseState {
  const ManageCourseInitial();
}

final class ManageCourseLoading extends ManageCourseState {
  const ManageCourseLoading();
}

final class ManageCourseSuccess extends ManageCourseState {
  const ManageCourseSuccess();
}

final class ManageCourseFailure extends ManageCourseState {
  const ManageCourseFailure(this.message);
  final String message;
}

final class ManageCourseUpdated extends ManageCourseState {}
