import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, FirebaseException;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/services/fire_store_service.dart'
    show FireStoreService;

class UserRepo {
  const UserRepo();
  static const FireStoreService _fireStoreService = FireStoreService();
  static const String _path = Endpoints.users;
  Future<void> add({required Map<String, dynamic> data, String? documentId}) =>
      _fireStoreService
          .add(data: data, path: _path, documentId: documentId)
          .then((_) => log('User added successfully!'))
          .onError<FirebaseException>((e, _) => log('Failed to add user: $e'))
          .catchError((e) => log('Failed to add user: $e'));
  Future<void> update({required Map<String, dynamic> data}) => _fireStoreService
      .update(data: data, path: _path, documentId: getUser()?.id)
      .then((_) => log('User updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update user: $e'))
      .catchError((e) => log('Failed to update user: $e'));
  Future<DocumentSnapshot<Map<String, dynamic>>> get({String? documentId}) =>
      _fireStoreService
          .getDocument(path: _path, documentId: documentId)
          .onError<FirebaseException>(
            (e, _) => throw Exception('Failed to get user: $e'),
          )
          .catchError((e) => throw Exception('Failed to get user: $e'));

  Future<void> delete() => _fireStoreService
      .delete(path: _path, documentId: getUser()?.id)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
