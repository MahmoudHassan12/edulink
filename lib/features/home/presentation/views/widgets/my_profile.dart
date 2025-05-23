import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(4),
    child: UserPhoto(user: getUser, isHero: true),
  );
}
