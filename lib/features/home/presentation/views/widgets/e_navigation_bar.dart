import 'package:flutter/material.dart';

class ENavigationBar extends StatelessWidget {
  const ENavigationBar({
    this.selectedIndex = 0,
    this.onDestinationSelected,
    super.key,
  });
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    const destinations = [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
        selectedIcon: Icon(Icons.home_rounded),
      ),
      NavigationDestination(
        icon: Icon(Icons.chat_bubble_outline_rounded),
        label: 'My Chats',
        selectedIcon: Icon(Icons.chat_bubble_rounded),
      ),
    ];
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      elevation: 0,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: destinations,
    );
  }
}
