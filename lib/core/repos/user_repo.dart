import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/entities_handlers.dart';
import 'package:edu_link/core/helpers/query_entity.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;
import 'package:edu_link/core/services/supabase_service.dart';

class UserRepo {
  const UserRepo();
  static const _fireStore = FirestoreService();
  static const _supabase = SupabaseService();
  static const String _path = Endpoints.users;

  Future<String> uploadImage(File file) =>
      _supabase.upload(_path, 'images', file);

  Future<bool> addToLocal(Map<String, dynamic> data) =>
      SharedPrefSingleton.setString(Endpoints.user, jsonEncode(data));

  Future<void> addToFireStore({
    required Map<String, dynamic> data,
    required String documentId,
  }) => _fireStore
      .addDocument(data: data, path: _path, documentId: documentId)
      .onError<FirebaseException>((e, _) async {
        await delete(documentId: documentId);
        throw Exception('Failed to add user: $e');
      })
      .catchError((e) async {
        await delete(documentId: documentId);
        throw Exception('Failed to add user: $e');
      });

  Future<void> add({
    required Map<String, dynamic> data,
    required String documentId,
  }) => addToFireStore(
    data: data,
    documentId: documentId,
  ).then((_) => addToLocal(data));

  Future<bool> udateLocal(Map<String, dynamic> data) =>
      SharedPrefSingleton.setString(Endpoints.user, jsonEncode(data));

  Future<void> updateFireStore({
    required Map<String, dynamic> data,
    required String documentId,
  }) => _fireStore
      .updateDocument(data: data, path: _path, documentId: documentId)
      .onError<FirebaseException>((e, _) => log('Failed to update user: $e'))
      .catchError((e) => log('Failed to update user: $e'));

  Future<void> update({
    required Map<String, dynamic> data,
    required String documentId,
  }) => updateFireStore(
    data: data,
    documentId: documentId,
  ).then((_) => udateLocal(data));

  Future<bool> isUserExist(String documentId) =>
      _fireStore.isDocumentExists(path: _path, documentId: documentId);

  UserEntity? getFromLocal() {
    final String encodedUser = SharedPrefSingleton.getString(Endpoints.user);
    if (encodedUser.isNotEmpty) {
      return UserEntity.fromMap(jsonDecode(encodedUser));
    }
    return null;
  }

  Future<UserEntity?> getFromFireStore({
    required String documentId,
    bool getCourses = false,
  }) {
    try {
      return _fireStore
          .getDocument(path: _path, documentId: documentId)
          .then(UserEntity.fromMap);
    } on FirebaseException catch (e) {
      log('Failed to get user: $e');
      rethrow;
    }
  }

  Future<List<UserEntity>?> getMultipleUsers(List<String> userIds) => _fireStore
      .getDocuments(path: _path, documentIds: userIds)
      .then((e) {
        log('${e.length} Users fetched successfully!');
        return e.map(UserEntity.fromMap).toList();
      })
      .onError<FirebaseException>((e, _) {
        log('Users not found');
        throw Exception('Users not found: $e');
      });

  /// Streams
  Stream<UserEntity?> stream({required String documentId}) => _fireStore
      .streamDocument(path: _path, documentId: documentId)
      .map(UserEntity.fromMap);

  Stream<List<UserEntity>?> streamUsersByCourse(String courseId) => _fireStore
      .streamCollectionWithQuery(
        path: _path,
        query: QueryEntity(
          fields: [FieldEntity(field: 'coursesIds', arrayContains: courseId)],
        ),
      )
      .map(
        (data) =>
            ListHandler.parseComplex<UserEntity>(data, UserEntity.fromMap),
      );

  Stream<List<UserEntity>?> getMultibleUsersStream(List<String> userIds) =>
      _fireStore.streamDocuments(path: _path, documentIds: userIds).asyncMap((
        docs,
      ) {
        log('${docs.length} Users fetched successfully!');
        return docs.map(UserEntity.fromMap).toList();
      });

  Future<void> delete({required String documentId}) => _fireStore
      .deleteDocument(path: _path, documentId: documentId)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
