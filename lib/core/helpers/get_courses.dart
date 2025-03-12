import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;

List<CourseEntity>? getCourses() {
  final courses = SharedPrefSingleton.getStringList(Endpoints.courses);
  if (courses?.isNotEmpty ?? false) {
    return courses?.map((e) => CourseEntity.fromMap(jsonDecode(e))).toList();
  }
  return null;
}

Future<void> getCoursesMethod() => FirebaseFirestore.instance
    .collection(Endpoints.courses)
    .get()
    .then(
      (e) => SharedPrefSingleton.setStringList(
        Endpoints.courses,
        e.docs
            .map((doc) => jsonEncode(CourseEntity.fromMap(doc.data()).toMap()))
            .toList(),
      ),
    )
    .catchError((e) {
      log('Error while fetching courses: $e');
      return false;
    });
