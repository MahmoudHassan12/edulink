part of 'courses_cubit.dart';

@immutable
sealed class CoursesState {
  const CoursesState();
}

final class CoursesInitial extends CoursesState {
  const CoursesInitial();
}

final class CoursesLoading extends CoursesState {
  const CoursesLoading();
}

final class CoursesSuccess extends CoursesState {
  const CoursesSuccess(this.courses);
  final List<CourseEntity> courses;
}

final class CoursesFailure extends CoursesState {
  const CoursesFailure(this.message);
  final String message;
}
