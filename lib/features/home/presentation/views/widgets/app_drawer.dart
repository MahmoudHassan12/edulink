import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart'
    show
        aboutNavigation,
        profileNavigation,
        registerCoursesNavigation,
        settingsNavigation;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

// Import UserEntity model

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final navigations = [
      {
        'icon': Icons.menu_book_rounded,
        'label': 'Available Courses',
        'action': registerCoursesNavigation,
      },
      {'icon': Icons.menu_book_rounded, 'label': 'My Courses', 'action': null},
      {'icon': Icons.favorite_rounded, 'label': 'Wishlist', 'action': null},
      {
        'icon': Icons.settings_rounded,
        'label': 'Settings',
        'action': settingsNavigation,
      },
      {'icon': Icons.help_rounded, 'label': 'About', 'action': aboutNavigation},
    ];

    return NavigationDrawer(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      onDestinationSelected:
          (index) async => (navigations[index]['action']
                  as Future<void> Function(BuildContext)?)
              ?.call(context),
      selectedIndex: null,
      children: [
        const _DrawerHeader(),
        ...navigations.map(
          (nav) => NavigationDrawerDestination(
            icon: Icon(nav['icon'] as IconData?),
            label: EText(nav['label']! as String),
          ),
        ),
      ],
    );
  }
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
            leading: UserPhoto(imageUrl: user?.imageUrl),
            title: EText(user?.name ?? 'No Name'),
            subtitle: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: EText(user?.email ?? 'No Email'),
            ),
          ),
          OutlinedButton(
            onPressed: () async => profileNavigation(context, extra: user),
            child: const Text('Manage your Account'),
          ),
        ],
      ),
    );
  }
}
