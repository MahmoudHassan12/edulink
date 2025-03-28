import 'dart:convert';
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';

UserEntity? get getUser {
  final encodedUser = SharedPrefSingleton.getString(Endpoints.user);
  if (encodedUser.isNotEmpty) {
    return UserEntity.fromMap(jsonDecode(encodedUser));
  }
  return null;
}
