import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart'
    show BuildContext, Center, StatelessWidget;

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});
  @override
  Center build(BuildContext context) =>
      const Center(child: EText('Profile View'));
}
