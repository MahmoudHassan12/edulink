import 'dart:async' show StreamController;
import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/entities_handlers.dart';
import 'package:edu_link/core/helpers/query_entity.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;
import 'package:edu_link/core/services/supabase_service.dart';

class UserRepo {
  const UserRepo();
  static const FirestoreService _fireStore = FirestoreService();
  static const SupabaseService _supabase = SupabaseService();
  static const String _path = Endpoints.users;

  Future<String> uploadImage(File file) async =>
      _supabase.upload(_path, 'images', file);

  Future<void> addUser({
    required Map<String, dynamic> data,
    required String documentId,
  }) => _fireStore
      .addDocument(data: data, path: _path, documentId: documentId)
      .then((_) async {
        await SharedPrefSingleton.setString(Endpoints.user, jsonEncode(data));
        log('User added successfully!');
      })
      .onError<FirebaseException>((e, _) async {
        await delete(documentId: documentId);
        log('Failed to add user: $e');
      })
      .catchError((e) async {
        await delete(documentId: documentId);
        log('Failed to add user: $e');
      });

  Future<void> update({
    required Map<String, dynamic> data,
    required String documentId,
  }) => _fireStore
      .updateDocument(data: data, path: _path, documentId: documentId)
      .then(
        (_) => SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(data),
        ).then((_) => log('User updated successfully!')),
      )
      .onError<FirebaseException>((e, _) => log('Failed to update user: $e'))
      .catchError((e) => log('Failed to update user: $e'));

  Future<UserEntity?> get({
    required String documentId,
    bool getCourses = false,
    bool toSharedPref = false,
  }) async {
    try {
      final data = await _fireStore.getDocument(
        path: _path,
        documentId: documentId,
      );
      final courses = getCourses
          ? (await const CoursesRepo().getMultibleCourses(
                  (data['coursesIds'] as List<dynamic>?)?.cast<String>() ?? [],
                ))?.toList() ??
                []
          : <CourseEntity>[];
      final user = UserEntity.fromMap(data).copyWith(courses: courses);
      if (toSharedPref) {
        await SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(user.toMap(toSharedPref: true)),
        );
      }
      return user;
    } on FirebaseException catch (e) {
      log('Failed to get user: $e');
      rethrow;
    }
  }

  Stream<List<UserEntity>?> streamUsersByCourse(String courseId) => _fireStore
      .streamCollectionWithQuery(
        path: _path,
        query: QueryEntity(
          fields: [FieldEntity(field: 'coursesIds', arrayContains: courseId)],
        ),
      )
      .map((data) => complexListEntity<UserEntity>(data, UserEntity.fromMap));

  Future<List<UserEntity>?> getMultipleUsers(List<String> userIds) => _fireStore
      .getDocuments(path: _path, documentIds: userIds)
      .then((e) async {
        log('${e.length} Users fetched successfully!');
        return Future.wait(
          e.map((e) async {
            return UserEntity.fromMap(e);
          }).toList(),
        );
      })
      .onError<FirebaseException>((e, _) {
        log('Users not found');
        throw Exception('Users not found: $e');
      });

  /// Streams
  Stream<UserEntity?> getStream({
    required String documentId,
    bool isProfessor = false,
  }) async* {
    final controller = StreamController<UserEntity?>();
    _fireStore.streamDocument(path: _path, documentId: documentId).listen((
      data,
    ) async {
      final user = UserEntity.fromMap(data);
      controller.add(user);
      if (isProfessor) return;
      final coursesIds = (data['coursesIds'] as List<dynamic>).cast<String>();
      const CoursesRepo().getMultibleCoursesStream(coursesIds).listen((
        courses,
      ) async {
        controller.add(user.copyWith(courses: courses));
      });
    });
    await for (final user in controller.stream) {
      yield user;
    }
    controller.onCancel = () async =>
        !controller.isClosed ? controller.close() : null;
  }

  Stream<List<UserEntity>?> getMultibleUsersStream(List<String> userIds) =>
      _fireStore.streamDocuments(path: _path, documentIds: userIds).asyncMap((
        docs,
      ) async {
        log('${docs.length} Users fetched successfully!');
        return Future.wait<UserEntity>(
          docs.map((e) async => UserEntity.fromMap(e)).toList(),
        );
      });

  Future<void> delete({required String documentId}) => _fireStore
      .deleteDocument(path: _path, documentId: documentId)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
