import 'dart:developer';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;

class AuthRepo {
  const AuthRepo();
  static const AuthService _auth = AuthService();
  static const UserRepo _userRepo = UserRepo();
  static final String? _uid = _auth.currentUser?.uid;

  Future<User?> signInWithEmail(String email, String password) =>
      _auth.signInWithEmail(email, password).then((user) async {
        if (user == null) return null;
        await _get(documentId: user.uid);
        return user;
      });

  Future<User?> signUpWithEmail(String email, String password) =>
      _auth.signUpWithEmail(email, password).then((user) async {
        final data = UserEntity(email: email, id: user?.uid).toMap();
        await _add(data: data, documentId: user!.uid);
        return user;
      });

  Future<User?> signInWithGoogle() async =>
      _auth.signInWithGoogle().then((user) async {
        if (user == null) return null;
        if ((await _get(documentId: user.uid)) != null) {
          await _get(documentId: user.uid);
        } else {
          final data = UserEntity(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            imageUrl: user.photoURL,
            phone: user.phoneNumber,
          ).toMap();
          await _add(data: data, documentId: user.uid);
        }
        return user;
      });

  Future<User?> signInWithFacebook() async =>
      _auth.signInWithFacebook().then((user) async {
        if (user == null) return null;
        if ((await _get(documentId: user.uid)) != null) {
          await _get(documentId: user.uid);
        } else {
          final data = UserEntity(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            imageUrl: user.photoURL,
            phone: user.phoneNumber,
          ).toMap();
          await _add(data: data, documentId: user.uid);
        }
        return user;
      });

  Future<void> _add({
    required Map<String, dynamic> data,
    required String documentId,
  }) => _userRepo
      .addUser(data: data, documentId: documentId)
      .onError<FirebaseException>((e, _) {
        log('Failed to add user: $e');
      })
      .catchError((e) {
        log('Failed to add user: $e');
      });

  Future<UserEntity?> _get({required String documentId}) => _userRepo.get(
    documentId: documentId,
    getCourses: true,
    toSharedPref: true,
  );

  Future<void> update() => _userRepo
      .update(data: getUser!.toMap(), documentId: _uid!)
      .then((_) => log('User updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update user: $e'))
      .catchError((e) => log('Failed to update user: $e'));

  Future<void> delete() => _userRepo
      .delete(documentId: _uid!)
      .then((_) => log('User deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete user: $e'))
      .catchError((e) => log('Failed to delete user: $e'));
}
