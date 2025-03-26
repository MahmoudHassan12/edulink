import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/services/auth_service.dart' show AuthService;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  @override
  Widget build(BuildContext context) => InkWell(
    // TODO(Anyone): Remove the next line after implementation
    onLongPress: () async => const AuthService().signOut(context),
    onTap: () async => profileNavigation(context),
    radius: 50,
    borderRadius: BorderRadius.circular(50),
    child: const Padding(
      padding: EdgeInsets.all(4),
      child: UserPhoto(isHero: true),
    ),
  );
}
