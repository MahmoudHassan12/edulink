part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.courses);
  final List<CourseEntity>? courses;
}

class HomeFailure extends HomeState {
  const HomeFailure(this.message);
  final String message;
}
