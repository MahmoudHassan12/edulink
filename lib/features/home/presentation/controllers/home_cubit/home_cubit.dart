import 'dart:async';

import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    unawaited(getCourses());
  }
  Future<void> getCourses() async {
    emit(const HomeLoading());
    if (getUser?.coursesIds?.isEmpty ?? true) {
      return emit(const HomeSuccess([]));
    }
    return const CoursesRepo()
        .getMultibleCourses(getUser!.coursesIds!)
        .then((courses) async {
          final List<String>? professorsIds = courses
              ?.map((e) => e.professor!.id!)
              .toList();
          final List<UserEntity>? professors = await const UserRepo()
              .getMultipleUsers(professorsIds!);
          final List<CourseEntity>? updatedCourses = courses
              ?.map(
                (e) => e.copyWith(
                  professor: professors?.firstWhere(
                    (professor) => professor.id == e.professor?.id,
                  ),
                ),
              )
              .toList();
          return emit(HomeSuccess(updatedCourses));
        })
        .onError((error, _) => emit(HomeFailure(error.toString())));
  }
}
