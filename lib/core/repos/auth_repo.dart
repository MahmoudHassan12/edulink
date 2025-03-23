import 'dart:convert' show jsonEncode;
import 'dart:developer';
import 'package:edu_link/core/constants/endpoints.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/services/fire_store_service.dart'
    show FireStoreService;
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;

class AuthRepo {
  const AuthRepo();
  static const AuthService _auth = AuthService();
  static const FireStoreService _fireStore = FireStoreService();
  static const UserRepo _userRepo = UserRepo();
  static const String _path = Endpoints.users;
  static final String? _uid = _auth.currentUser?.uid;

  Future<User?> signInWithEmail(String email, String password) =>
      _auth.signInWithEmail(email, password).then((user) async {
        await _get(documentId: user?.uid);
        return user;
      });

  Future<User?> signUpWithEmail(String email, String password) =>
      _auth.signUpWithEmail(email, password).then((user) {
        final data = UserEntity(email: email, id: user?.uid).toMap();
        SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(UserEntity.fromMap(data).toMap()),
        );
        _add(data: data, documentId: user?.uid);
        return user;
      });

  Future<User?> signInWithGoogle() async =>
      _auth.signInWithGoogle().then((user) async {
        if ((await _userRepo.get(documentId: user?.uid)).exists) {
          await _get(documentId: user?.uid);
        } else {
          final data =
              UserEntity(
                id: user?.uid,
                name: user?.displayName,
                email: user?.email,
                imageUrl: user?.photoURL,
                phone: user?.phoneNumber,
              ).toMap();
          await _add(data: data, documentId: user?.uid);
          await SharedPrefSingleton.setString(
            Endpoints.user,
            jsonEncode(UserEntity.fromMap(data).toMap()),
          );
        }
        return user;
      });

  Future<User?> signInWithFacebook() async =>
      _auth.signInWithFacebook().then((user) async {
        if ((await _userRepo.get(documentId: user?.uid)).exists) {
          await _get(documentId: user?.uid);
        } else {
          final data =
              UserEntity(
                id: user?.uid,
                name: user?.displayName,
                email: user?.email,
                imageUrl: user?.photoURL,
                phone: user?.phoneNumber,
              ).toMap();
          await _add(data: data, documentId: user?.uid).then(
            (_) => SharedPrefSingleton.setString(
              Endpoints.user,
              jsonEncode(UserEntity.fromMap(data).toMap()),
            ),
          );
        }
        return user;
      });

  Future<void> _add({required Map<String, dynamic> data, String? documentId}) =>
      _fireStore
          .add(data: data, path: _path, documentId: documentId)
          .then((_) => log('User added successfully!'))
          .onError<FirebaseException>((e, _) => log('Failed to add user: $e'))
          .catchError((e) => log('Failed to add user: $e'));

  Future<bool> _get({String? documentId}) => _userRepo
      .get(documentId: documentId)
      .then(
        (doc) => SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(UserEntity.fromMap(doc.data()).toMap()),
        ),
      );

  Future<void> update() => _fireStore
      .update(data: getUser()!.toMap(), path: _path, documentId: _uid)
      .then((_) => log('User updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update user: $e'))
      .catchError((e) => log('Failed to update user: $e'));

  Future<void> delete() => _fireStore
      .delete(path: _path, documentId: _uid)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
