import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
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
    String? documentId,
  }) => _fireStore
      .addDocument(data: data, path: _path, documentId: documentId)
      .then((_) {
        SharedPrefSingleton.setString(Endpoints.user, jsonEncode(data));
        log('User added successfully!');
      })
      .onError<FirebaseException>((e, _) {
        delete(documentId: documentId);
        log('Failed to add user: $e');
      })
      .catchError((e) {
        delete(documentId: documentId);
        log('Failed to add user: $e');
      });

  Future<void> update({
    required Map<String, dynamic> data,
    String? documentId,
  }) => _fireStore
      .update(data: data, path: _path, documentId: documentId)
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
    bool isProfessor = false,
  }) async {
    try {
      final doc = await _fireStore.getDocument(
        path: _path,
        documentId: documentId,
      );
      final data = doc.data();
      if (data == null) {
        log('User not found');
        return null;
      }
      final courses =
          isProfessor
              ? <CourseEntity>[]
              : (await const CoursesRepo().getMultibleCourses(
                    (data['coursesIds'] as List<dynamic>?)?.cast<String>() ??
                        [],
                  ))?.toList() ??
                  [];
      final user = UserEntity.fromMap(data).copyWith(courses: courses);
      if (!isProfessor) {
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

  Stream<UserEntity?> getStream({
    required String documentId,
    bool isProfessor = false,
  }) => _fireStore
      .getDocumentStream(path: _path, documentId: documentId)
      .asyncMap((doc) async {
        final data = doc.data();
        if (data == null) {
          log('User not found');
          return null;
        }
        final coursesIds =
            (data['coursesIds'] as List<dynamic>?)?.cast<String>();
        final user = UserEntity.fromMap(data);
        if (coursesIds?.isEmpty ?? true) return user;
        final courses = await const CoursesRepo().getMultibleCourses(
          coursesIds,
        );
        final updatedUser = user.copyWith(courses: courses?.toList());
        if (!isProfessor) {
          await SharedPrefSingleton.setString(
            Endpoints.user,
            jsonEncode(updatedUser.toMap(toSharedPref: true)),
          );
        }
        return updatedUser;
      });

  Stream<UserEntity?> getStreama({
    required String documentId,
    bool isProfessor = false,
  }) => _fireStore
      .getDocumentStream(path: _path, documentId: documentId)
      .asyncExpand((doc) async* {
        final data = doc.data();
        if (data == null) {
          log('User not found');
          yield null;
          return;
        }
        final coursesIds =
            (data['coursesIds'] as List<dynamic>?)?.cast<String>();
        final user = UserEntity.fromMap(data);
        if (coursesIds?.isEmpty ?? true) {
          yield user;
          return;
        }
        // Merge with courses stream
        yield* const CoursesRepo().getMultibleCoursesStream(coursesIds).map((
          courses,
        ) {
          final updatedUser = user.copyWith(
            courses: isProfessor ? <CourseEntity>[] : courses?.toList(),
          );
          if (!isProfessor) {
            SharedPrefSingleton.setString(
              Endpoints.user,
              jsonEncode(updatedUser.toMap(toSharedPref: true)),
            );
          }
          return updatedUser;
        });
      });

  Future<List<UserEntity>?> getMultipleUsers(List<String?>? userIds) =>
      _fireStore
          .getMultibleDocuments(path: _path, documentIds: userIds)
          .then((docs) async {
            log('${docs?.length} Users fetched successfully!');
            return Future.wait(
              docs?.map((e) async {
                    final data = e.data();
                    return UserEntity.fromMap(data);
                  }).toList() ??
                  <Future<UserEntity>>[],
            );
          })
          .onError<FirebaseException>((e, _) {
            log('Users not found');
            throw Exception('Users not found: $e');
          });

  Future<void> delete({String? documentId}) => _fireStore
      .delete(path: _path, documentId: documentId)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
