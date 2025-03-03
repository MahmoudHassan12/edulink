import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
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
      IconButton(
        icon: const Icon(Icons.edit_rounded),
        onPressed: () {},
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      const SizedBox(width: 8),
    ],
  );
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
