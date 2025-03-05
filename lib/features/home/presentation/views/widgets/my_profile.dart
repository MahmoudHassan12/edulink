import 'dart:developer';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/auth_service.dart' show AuthService;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/helpers/shared_pref.dart' show SharedPrefHelper;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserEntity?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          log('FutureBuilder Error: ${snapshot.error}');
          return const Icon(Icons.error, color: Colors.red);
        }
        final user = snapshot.data;
        if (user == null) {
          log('User data is null');
          return InkWell(
            onLongPress: () async {
              await AuthService().signOut();
              await SharedPrefHelper.clearSession();
              if (context.mounted) await signinNavigation(context);
            },
            radius: 50,
            borderRadius: BorderRadius.circular(50),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.person_off, color: Colors.grey),
            ),
          );
        }
        return InkWell(
          onTap: () async => profileNavigation(context, extra: user),
          radius: 50,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: UserPhoto(imageUrl: user.imageUrl ?? '', isHero: true),
          ),
        );
      },
    );
  }
}
