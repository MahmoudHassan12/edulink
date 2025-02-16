import 'package:edu_link/features/home/presentation/views/widgets/home_view_body.dart'
    show HomeViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget, Text;

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: const HomeViewBody(),
  );
}
