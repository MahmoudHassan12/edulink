import 'dart:developer';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;

class AuthRepo {
  const AuthRepo();
  static const _auth = AuthService();
  static const _userRepo = UserRepo();
  static final String? _uid = _auth.currentUser?.uid;

  Future<User?> signInWithEmail(String email, String password) =>
      _auth.signInWithEmail(email, password).then((user) async {
        if (user == null) {
          return null;
        }
        await _get(documentId: user.uid);
        return user;
      });

  Future<User?> signUpWithEmail(String email, String password) =>
      _auth.signUpWithEmail(email, password).then((user) async {
        await _userRepo.add(
          data: UserEntity.fromFireBase(user).toMap(),
          documentId: user!.uid,
        );
        return user;
      });

  Future<User?> signInWithGoogle() =>
      _auth.signInWithGoogle().then((user) async {
        if (user == null) {
          return null;
        }
        if (await _userRepo.isUserExist(user.uid)) {
          await _get(documentId: user.uid);
        } else {
          await _userRepo.add(
            data: UserEntity.fromFireBase(user).toMap(),
            documentId: user.uid,
          );
        }
        return user;
      });

  Future<User?> signInWithFacebook() => _auth.signInWithFacebook().then((
    user,
  ) async {
    if (user == null) {
      return null;
    }
    if (await _userRepo.isUserExist(user.uid)) {
      await _get(documentId: user.uid);
    } else {
      final Map<String, dynamic> data = UserEntity.fromFireBase(user).toMap();
      await _userRepo.add(data: data, documentId: user.uid);
    }
    return user;
  });

  Future<UserEntity?> _get({required String documentId}) async {
    final UserEntity? user = await _userRepo.getFromFireStore(
      documentId: documentId,
      getCourses: true,
    );
    await _userRepo.addToLocal(user!.toMap());
    return user;
  }

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
