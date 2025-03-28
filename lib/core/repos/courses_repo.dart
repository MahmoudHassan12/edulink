import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;
import 'package:edu_link/core/services/supabase_service.dart'
    show SupabaseService;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseException;

class CoursesRepo {
  const CoursesRepo();
  static const FirestoreService _fireStore = FirestoreService();
  static const String _coursesPath = Endpoints.courses;

  Future<String> uploadImage(File file) async =>
      const SupabaseService().upload(_coursesPath, 'images', file);

  Future<void> add({required Map<String, dynamic> data, String? documentId}) =>
      _fireStore
          .addDocument(data: data, path: _coursesPath, documentId: documentId)
          .then((_) => log('Course added successfully!'))
          .onError<FirebaseException>((e, _) => log('Failed to add course: $e'))
          .catchError((e) => log('Failed to add course: $e'));

  Future<void> addCoursesIds(List<String> courseIds) => _fireStore
      .addListInDocument(
        path: Endpoints.users,
        listKey: 'coursesIds',
        list: courseIds,
        documentId: getUser?.id,
      )
      .then((_) {
        final courses = List<CourseEntity>.empty(growable: true);
        courseIds.map((id) => courses.add(CourseEntity(id: id))).toList();
        final user = getUser?.copyWith(courses: courses);
        SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(user?.toMap(toSharedPref: true)),
        );
        log('User added successfully!');
      });

  Future<List<CourseEntity>?> getMultibleCourses(List<String?>? courseIds) =>
      _fireStore
          .getMultibleDocuments(path: _coursesPath, documentIds: courseIds)
          .then((docs) async {
            log('${docs?.length} Courses fetched successfully!');
            return Future.wait(
              docs?.map((e) async {
                    final data = e.data();
                    final professor = await const UserRepo().get(
                      documentId: data?['professorId'],
                      isProfessor: true,
                    );
                    return CourseEntity.fromMap(
                      data,
                    ).copyWith(professor: professor);
                  }).toList() ??
                  <Future<CourseEntity>>[],
            );
          });

  Future<void> update({
    required Map<String, dynamic> data,
    String? documentId,
  }) => _fireStore
      .update(data: data, path: _coursesPath, documentId: documentId)
      .then((_) => log('Course updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update course: $e'))
      .catchError((e) => log('Failed to update course: $e'));

  Future<List<CourseEntity>?> getAll() => _fireStore
      .getAll(path: _coursesPath)
      .then((e) async {
        final docs = e.docs;
        log('${docs.length} Courses fetched successfully!');
        final courses = await Future.wait<CourseEntity>(
          docs.map((e) async {
            final data = e.data();
            final professor = await const UserRepo().get(
              documentId: data['professorId'],
              isProfessor: true,
            );
            final course = CourseEntity.fromMap(
              data,
            ).copyWith(professor: professor);
            return course;
          }),
        );
        return courses;
      })
      .onError<FirebaseException>(
        (e, _) => throw Exception('Failed to fetch courses: $e'),
      )
      .catchError((e) => throw Exception('Failed to fetch courses: $e'));

  Future<void> delete({String? documentId}) => _fireStore
      .delete(path: _coursesPath, documentId: documentId)
      .then((_) => log('Course deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete course: $e'))
      .catchError((e) => log('Failed to delete course: $e'));
}
