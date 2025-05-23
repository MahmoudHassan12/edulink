import 'dart:async';

import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    _streamCourses();
  }
  StreamSubscription<UserEntity?> _streamCourses() {
    emit(const HomeLoading());
    return _streamUser().listen(
      (user) => const CoursesRepo()
          .streamMultibleCourses(user!.coursesIds!)
          .listen((courses) => emit(HomeSuccess(courses))),
    );
  }

  Stream<UserEntity?> _streamUser() =>
      const UserRepo().stream(documentId: getUser!.id!);
}
