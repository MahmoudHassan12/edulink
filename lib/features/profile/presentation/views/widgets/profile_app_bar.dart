import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});
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
        onPressed: () async => manageProfileNavigation(context),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      const SizedBox(width: 8),
    ],
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
