import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_view_body.dart'
    show ProfileViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget;

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const EText('Profile')),
    body: const ProfileViewBody(),
  );
}
