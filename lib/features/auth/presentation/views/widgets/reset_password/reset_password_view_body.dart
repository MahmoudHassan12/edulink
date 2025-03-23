import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/custom_auth_app_bar.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  CustomScrollView build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAuthAppBar(isLoading: isLoading, title: 'Reset Password'),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.list(
            children: [
              const EText('Enter your email address'),
              const SizedBox(height: 16),
              EmailTextField(isLoading: isLoading),
              CustomFilledButton(
                label: 'Reset Password',
                onPressed: isLoading ? null : () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
