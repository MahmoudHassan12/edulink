import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, FirebaseException;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
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
      .then((_) => log('User added successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to add user: $e'))
      .catchError((e) => log('Failed to add user: $e'));
  Future<void> addCoursesId(List<String> courseIds) => _fireStore
      .addListInDocument(
        path: _path,
        listKey: 'coursesId',
        list: courseIds,
        documentId: getUser()?.id,
      )
      .then((_) {
        final courses = List<CourseEntity>.empty(growable: true);
        courseIds.map((id) => courses.add(CourseEntity(id: id))).toList();
        final user = getUser()?.copyWith(courses: courses);
        SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(user?.toMap()),
        );
        log('User added successfully!');
      });
  Future<void> update({required Map<String, dynamic> data}) => _fireStore
      .update(data: data, path: _path, documentId: getUser()?.id)
      .then(
        (_) => SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(data),
        ).then((_) => log('User updated successfully!')),
      )
      .onError<FirebaseException>((e, _) => log('Failed to update user: $e'))
      .catchError((e) => log('Failed to update user: $e'));
  Future<DocumentSnapshot<Map<String, dynamic>>> get({String? documentId}) =>
      _fireStore
          .getDocument(path: _path, documentId: documentId)
          .onError<FirebaseException>(
            (e, _) => throw Exception('Failed to get user: $e'),
          )
          .catchError((e) => throw Exception('Failed to get user: $e'));

  Future<void> delete() => _fireStore
      .delete(path: _path, documentId: getUser()?.id)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
