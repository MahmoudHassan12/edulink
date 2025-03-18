import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/core/repos/courses_repo.dart';

List<CourseEntity>? getCourses() {
  final courses = SharedPrefSingleton.getStringList(Endpoints.courses);
  if (courses?.isNotEmpty ?? false) {
    return courses?.map((e) => CourseEntity.fromMap(jsonDecode(e))).toList();
  }
  return null;
}

Future<bool> getCoursesMethod() => const CoursesRepo()
    .getAll()
    .then(
      (e) => SharedPrefSingleton.setStringList(
        Endpoints.courses,
        e?.map((course) => jsonEncode(course.toMap())).toList() ?? [],
      ),
    )
    .catchError((e) {
      log('Error while fetching courses: $e');
      return false;
    });
