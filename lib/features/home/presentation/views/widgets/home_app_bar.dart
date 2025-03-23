import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/views/widgets/app_bar_bottom.dart';
import 'package:edu_link/features/home/presentation/views/widgets/my_profile.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) => const SliverAppBar.medium(
    title: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.5),
      child: EText('Home'),
    ),
    centerTitle: true,
    actions: [MyProfile()],
    bottom: AppBarBottom(),
    actionsPadding: EdgeInsets.only(right: 8),
  );
}
