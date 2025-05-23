import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/user_photo.dart' show UserPhoto;
import 'package:edu_link/features/home/presentation/views/widgets/app_bar_bottom.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) => SliverAppBar.medium(
    title: const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.5),
      child: EText('Home'),
    ),
    centerTitle: true,
    actions: [UserPhoto(user: getUser!, isHero: true)],
    bottom: const AppBarBottom(),
    actionsPadding: const EdgeInsets.only(right: 8),
  );
}
