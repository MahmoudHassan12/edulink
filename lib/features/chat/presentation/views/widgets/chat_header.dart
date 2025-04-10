import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChatHeader({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: Colors.transparent,
    title: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: UserPhoto(user: user),
      title: EText(user.name!, style: const TextStyle(fontSize: 18)),
    ),
  );
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
