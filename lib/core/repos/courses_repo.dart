import 'dart:developer' show log;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/services/fire_store_service.dart'
    show FireStoreService;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseException;

class CoursesRepo {
  const CoursesRepo();
  static const FireStoreService _fireStore = FireStoreService();
  static const String _path = Endpoints.courses;
  Future<void> add({required Map<String, dynamic> data, String? documentId}) =>
      _fireStore
          .add(data: data, path: _path, documentId: documentId)
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
      .then((e) {
        final docs = e.docs;
        log('${docs.length} Courses fetched successfully!');
        return docs.map((e) => CourseEntity.fromMap(e.data())).toList();
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
