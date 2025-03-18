import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/auth_service.dart' show AuthService;
import 'package:edu_link/core/widgets/buttons/custom_elevated_button.dart'
    show CustomElevatedButton;
import 'package:edu_link/core/widgets/buttons/custom_filled_button_tonal.dart'
    show CustomFilledButtonTonal;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/features/profile/presentation/views/widgets/first_panal_with_decoration.dart'
    show FirstPanalWithDecoration;
import 'package:edu_link/features/profile/presentation/views/widgets/second_panal.dart'
    show SecondPanal;
import 'package:edu_link/features/profile/presentation/views/widgets/third_panal.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({required this.user, super.key});
  final UserEntity user;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      FirstPanalWithDecoration(user: user),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        sliver: SliverList.list(
          children: [
            const SizedBox(height: 12),
            const _Label('Contact Information'),
            SecondPanal(user: user),
            const SizedBox(height: 12),
            if (user.isProfessor) ...[
              const _Label('Office hours & availability'),
              ThirdPanal(user: user),
            ] else
              CustomElevatedButton.icon(
                onPressed: () {},
                label: 'More Details',
                icon: Icons.arrow_forward_ios_rounded,
              ),
            const SizedBox(height: 12),
            CustomFilledButtonTonal.icon(
              onPressed: () async => const AuthService().signOut(context),
              label: 'Log Out',
              icon: Icons.logout_rounded,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          ],
        ),
      ),
    ],
  );
}

class _Label extends StatelessWidget {
  const _Label(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => ListTile(
    minVerticalPadding: 0,
    contentPadding: EdgeInsets.zero,
    title: EText(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}
