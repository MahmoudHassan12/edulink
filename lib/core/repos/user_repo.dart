import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/services/fire_store_service.dart'
    show FireStoreService;

class UserRepo {
  final FireStoreService fireStoreService = FireStoreService();
  final _path = Endpoints.user;
  Future<void> add({required Map<String, dynamic> data, String? documentId}) =>
      fireStoreService.add(data: data, path: _path, documentId: documentId);
  Future<void> update({required Map<String, dynamic> data}) => fireStoreService
      .update(data: data, path: _path, documentId: getUser()?.id);
  Future<DocumentSnapshot<Map<String, dynamic>>> get({String? documentId}) =>
      fireStoreService.get(path: _path, documentId: documentId);
  Future<void> delete() =>
      fireStoreService.delete(path: _path, documentId: getUser()?.id);
}
