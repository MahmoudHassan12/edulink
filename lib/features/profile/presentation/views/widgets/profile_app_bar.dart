import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/features/chat/widgets/chat_view_body.dart'
    show ChatScreen;
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => AppBar(
    leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
    title: EText(
      'Profile',
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    ),
    centerTitle: true,
    forceMaterialTransparency: true,
    elevation: 0,
    actions: [
      if (user.id == getUser?.id)
        IconButton(
          icon: const Icon(Icons.edit_rounded),
          onPressed: () async => manageProfileNavigation(context),
          color: Theme.of(context).colorScheme.onPrimary,
        )
      else
        IconButton(
          icon: const Icon(Icons.chat_rounded),
          onPressed:
              () async => Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => ChatScreen(
                        userId1: getUser!.id!,
                        userId2: user.id!,
                        user1Name: getUser!.name!,
                        user2Name: user.name!,
                        user1ImgUrl: getUser!.imageUrl!,
                        user2ImgUrl: user.imageUrl!,
                        currentUserId: getUser!.id!,
                      ),
                ),
              ),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      const SizedBox(width: 8),
    ],
  );
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
