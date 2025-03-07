import 'package:edu_link/core/helpers/auth_service.dart' show AuthService;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  @override
  Widget build(BuildContext context) {
    final user = getUser();
    return InkWell(
      // TODO(Anyone): Remove this line after implementation
      onLongPress: () async => AuthService().signOut(context),
      onTap: () async => profileNavigation(context, extra: user),
      radius: 50,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: UserPhoto(imageUrl: user?.imageUrl, isHero: true),
      ),
    );
  }
}
