import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileBottomAppBar extends StatelessWidget {
  const ProfileBottomAppBar({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => BottomAppBar(
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.linkedinIn),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.facebookF),
          onPressed: () {},
        ),
        IconButton(icon: const Icon(FontAwesomeIcons.github), onPressed: () {}),
      ],
    ),
  );
}
