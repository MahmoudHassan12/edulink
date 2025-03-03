import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart'
    show aboutNavigation, settingsNavigation, studentProfileNavigation;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) => NavigationDrawer(
    tilePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    selectedIndex: null,
    onDestinationSelected: (index) async {
      switch (index) {
        case 0:
          return;
        case 1:
          return;
        case 2:
          return settingsNavigation(context);
        case 3:
          return aboutNavigation(context);
        default:
          return;
      }
    },
    children: const [
      _DrawerHeader(),
      NavigationDrawerDestination(
        icon: Icon(Icons.menu_book_rounded),
        label: EText('My Courses'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.favorite_rounded),
        label: EText('Wishlist'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.settings_rounded),
        label: EText('Settings'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.help_rounded),
        label: EText('About'),
      ),
    ],
  );
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();
  @override
  Widget build(BuildContext context) {
    final user = getUser();
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: UserPhoto(imageUrl: user.imageUrl!),
            title: EText(user.name!),
            subtitle: FittedBox(child: EText(user.email!)),
          ),
          OutlinedButton(
            onPressed:
                () async => studentProfileNavigation(context, extra: user),
            child: const Text('Manage your Account'),
          ),
        ],
      ),
    );
  }
}
