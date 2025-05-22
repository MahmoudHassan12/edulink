import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/chat/presentation/views/chat_list_view.dart';
import 'package:edu_link/features/home/presentation/views/widgets/app_drawer.dart';
import 'package:edu_link/features/home/presentation/views/widgets/e_navigation_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_view_body.dart'
    show HomeViewBody;
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 1;
  void _onDestinationSelected(int index) =>
      index != _selectedIndex ? setState(() => _selectedIndex = index) : null;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: _pages[_selectedIndex],
    floatingActionButton: (getUser?.isProfessor ?? false) && _selectedIndex == 1
        ? const _AddCourseFloatingButton()
        : null,
    drawer: const AppDrawer(),
    bottomNavigationBar: ENavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onDestinationSelected,
    ),
  );
}

const List<Widget> _pages = [ChatListView(), HomeViewBody(), SizedBox()];

class _AddCourseFloatingButton extends StatelessWidget {
  const _AddCourseFloatingButton();
  @override
  FloatingActionButton build(BuildContext context) => FloatingActionButton(
    onPressed: () async => manageCourseNavigation(context),
    child: const Icon(Icons.add_rounded),
  );
}
