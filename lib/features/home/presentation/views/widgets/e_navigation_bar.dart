import 'package:flutter/material.dart';

class ENavigationBar extends StatefulWidget {
  const ENavigationBar({super.key});
  @override
  State<ENavigationBar> createState() => _ENavigationBarState();
}

class _ENavigationBarState extends State<ENavigationBar> {
  final _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home_rounded),
    ),
    NavigationDestination(
      icon: Icon(Icons.menu_book_outlined),
      label: 'My Courses',
      selectedIcon: Icon(Icons.menu_book_rounded),
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_outline_rounded),
      label: 'Wishlist',
      selectedIcon: Icon(Icons.favorite_rounded),
    ),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) => NavigationBar(
    onDestinationSelected: _onItemTapped,
    selectedIndex: _selectedIndex,
    elevation: 0,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    destinations: _destinations,
  );
}
