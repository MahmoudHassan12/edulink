import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
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
    floatingActionButton:
        (getUser?.isProfessor ?? false)
            ? const AddCourseFloatingButton()
            : null,
    drawer: const AppDrawer(),
    bottomNavigationBar: const ENavigationBar(),
  );
}

class AddCourseFloatingButton extends StatelessWidget {
  const AddCourseFloatingButton({super.key});
  @override
  FloatingActionButton build(BuildContext context) => FloatingActionButton(
    onPressed: () async => manageCourseNavigation(context),
    child: const Icon(Icons.add_rounded),
  );
}
