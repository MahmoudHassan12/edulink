import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/custom_auth_app_bar.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({this.isLoading = false, super.key});
  final bool isLoading;

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      CustomAuthAppBar(isLoading: widget.isLoading, title: 'Reset Password'),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const EText('Enter your email address'),
            const SizedBox(height: 16),
            EmailTextField(
              isLoading: widget.isLoading,
              emailController: _emailController,
            ),
            CustomFilledButton(
              label: 'Reset Password',
              onPressed: widget.isLoading
                  ? null
                  : () async {
                      await const AuthRepo().sendPasswordResetEmail(
                        _emailController.text,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: EText('Password reset email sent!'),
                          ),
                        );
                        popNavigation(context);
                      }
                    },
            ),
          ],
        ),
      ),
    ],
  );
}
