import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart'
    show
        aboutNavigation,
        registerCoursesNavigation,
        settingsNavigation,
        studentProfileNavigation;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

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
      selectedIndex: null,
      onDestinationSelected: (index) {
        final action = navigations[index]['action'] as Function(BuildContext)?;
        if (action != null) {
          action(context);
        }
      },
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
