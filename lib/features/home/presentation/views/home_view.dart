import 'package:edu_link/features/home/presentation/views/widgets/app_drawer.dart';
import 'package:edu_link/features/home/presentation/views/widgets/e_navigation_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_view_body.dart'
    show HomeViewBody;
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    body: const HomeViewBody(),
    floatingActionButton: FloatingActionButton(onPressed: () {}),
    drawer: const AppDrawer(),
    bottomNavigationBar: const ENavigationBar(),
  );
}
