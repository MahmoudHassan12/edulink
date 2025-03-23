import 'dart:async';
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/repos/courses_repo.dart' show CoursesRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(const CoursesInitial()) {
    unawaited(getCourses());
  }
  Future<void> getCourses() async {
    emit(const CoursesLoading());
    await const CoursesRepo()
        .getAll()
        .then((courses) {
          emit(CoursesSuccess(courses!));
        })
        .catchError((e) {
          emit(CoursesFailure(e.toString()));
        });
  }
}
