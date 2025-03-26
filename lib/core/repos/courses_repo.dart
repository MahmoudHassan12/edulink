import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;
import 'package:edu_link/core/services/supabase_service.dart'
    show SupabaseService;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseException;

class CoursesRepo {
  const CoursesRepo();
  static const FirestoreService _fireStore = FirestoreService();
  static const SupabaseService _supabase = SupabaseService();
  static const String _path = Endpoints.courses;

  Future<String> uploadImage(File file) async =>
      _supabase.upload(_path, 'images', file);

  Future<void> add({required Map<String, dynamic> data, String? documentId}) =>
      _fireStore
          .addDocument(data: data, path: _path, documentId: documentId)
          .then((_) => log('Course added successfully!'))
          .onError<FirebaseException>((e, _) => log('Failed to add course: $e'))
          .catchError((e) => log('Failed to add course: $e'));

  Future<void> update({
    required Map<String, dynamic> data,
    String? documentId,
  }) => _fireStore
      .update(data: data, path: _path, documentId: documentId)
      .then((_) => log('Course updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update course: $e'))
      .catchError((e) => log('Failed to update course: $e'));

  Future<List<CourseEntity>?> getAll() => _fireStore
      .getAll(path: _path)
      .then((e) async {
        final docs = e.docs;
        log('${docs.length} Courses fetched successfully!');
        final courses = await Future.wait<CourseEntity>(
          docs.map((e) async {
            final data = e.data();
            final user = await const UserRepo().get(
              documentId: data['professorId'],
            );
            final course = CourseEntity.fromMap(
              data,
            ).copyWith(professor: UserEntity.fromMap(user.data()));
            return course;
          }),
        );
        await SharedPrefSingleton.setStringList(
          Endpoints.courses,
          courses.map((course) => jsonEncode(course.toMap())).toList(),
        );
        return courses;
      })
      .onError<FirebaseException>(
        (e, _) => throw Exception('Failed to fetch courses: $e'),
      )
      .catchError((e) => throw Exception('Failed to fetch courses: $e'));

  Future<void> delete({String? documentId}) => _fireStore
      .delete(path: _path, documentId: documentId)
      .then((_) => log('Course deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete course: $e'))
      .catchError((e) => log('Failed to delete course: $e'));
}
