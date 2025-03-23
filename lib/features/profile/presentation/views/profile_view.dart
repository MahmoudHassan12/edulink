import 'package:edu_link/features/profile/presentation/views/widgets/profile_app_bar.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_bottom_app_bar.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Scaffold build(BuildContext context) => const Scaffold(
    extendBodyBehindAppBar: true,
    appBar: ProfileAppBar(),
    body: ProfileViewBody(),
    bottomNavigationBar: ProfileBottomAppBar(),
  );
}
