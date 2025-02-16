import 'package:edu_link/features/home/presentation/views/widgets/home_view_body.dart'
    show HomeViewBody;
import 'package:flutter/material.dart'
    show BuildContext, Scaffold, StatelessWidget, Widget;

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: HomeViewBody());
}
