import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/auth_service.dart' show AuthService;
import 'package:edu_link/core/helpers/navigations.dart' show signinNavigation;
import 'package:edu_link/core/helpers/shared_pref.dart' show SharedPrefHelper;
import 'package:edu_link/core/widgets/buttons/custom_elevated_button.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button_tonal.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/first_panal_with_decoration.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/second_panal.dart';
import 'package:flutter/material.dart';

class StudentProfileViewBody extends StatelessWidget {
  const StudentProfileViewBody({required this.user, super.key});
  final UserEntity user;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      FirstPanalWithDecoration(user: user),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        sliver: SliverList.list(
          children: [
            const ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: EText(
                'Contact Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SecondPanal(user: user),
            const SizedBox(height: 16),
            CustomElevatedButton.icon(
              onPressed: () {},
              label: 'More Details',
              icon: Icons.arrow_forward_ios_rounded,
            ),
            const SizedBox(height: 16),
            CustomFilledButtonTonal.icon(
              onPressed: () async {
                await AuthService().signOut();
                await SharedPrefHelper.clearSession();
                if (context.mounted) await signinNavigation(context);
              },
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
