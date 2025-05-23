import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/custom_auth_app_bar.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/having_account.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/continue_with_facebook_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/continue_with_google_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_form.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => CustomScrollView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    slivers: [
      CustomAuthAppBar(isLoading: isLoading, title: 'Sign In'),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList(
          delegate: SliverChildListDelegate.fixed([
            const SizedBox(height: 8),
            SignInForm(isLoading: isLoading),
            const SizedBox(height: 32),
            HavingAccount(
              isLoading: isLoading,
              content: "Don't have an account?",
              title: 'Sign Up',
              onTap: () => registerNavigation(context),
            ),
            const SizedBox(height: 32),
            const OrDivider(),
            const SizedBox(height: 32),
            ContinueWithGoogleButton(isLoading: isLoading),
            const SizedBox(height: 16),
            ContinueWithFacebookButton(isLoading: isLoading),
            const SizedBox(height: 16),
          ]),
        ),
      ),
    ],
  );
}
