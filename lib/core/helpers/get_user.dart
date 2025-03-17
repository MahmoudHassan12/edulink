import 'dart:convert';
import 'dart:developer';
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
// import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/core/repos/user_repo.dart';

UserEntity? getUser() {
  final user = SharedPrefSingleton.getString(Endpoints.user);
  if (user.isNotEmpty) {
    return UserEntity.fromMap(jsonDecode(user));
  }
  return null;
}

Future<bool?> getUserMethod() async {
  final currentUser = AuthService().currentUser;
  if (currentUser == null) {
    log('Error: No current user found');
    return null;
  }
  try {
    final docSnapshot = await UserRepo().get(documentId: currentUser.uid);
    if (!docSnapshot.exists) {
      log('Error: User document does not exist for ID: ${currentUser.uid}');
      return null;
    }
    final data = docSnapshot.data();
    if (data == null) {
      log('Error: User data is null');
      return null;
    }
    // log('Fetched User Data: $data');
    return SharedPrefSingleton.setString(
      Endpoints.user,
      jsonEncode(UserEntity.fromMap(data).toMap()),
    );
  } catch (e) {
    log('Error while fetching user data: $e');
    return null;
  }
}
