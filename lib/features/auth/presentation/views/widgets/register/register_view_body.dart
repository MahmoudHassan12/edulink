import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/custom_auth_app_bar.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/having_account.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/register/register_form.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        CustomScrollView,
        EdgeInsets,
        ScrollViewKeyboardDismissBehavior,
        SizedBox,
        SliverChildListDelegate,
        SliverList,
        SliverPadding,
        StatelessWidget;

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    slivers: [
      CustomAuthAppBar(
        isLoading: isLoading,
        title: 'Register',
        automaticallyImplyLeading: false,
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList(
          delegate: SliverChildListDelegate.fixed([
            const SizedBox(height: 8),
            RegisterForm(isLoading: isLoading),
            const SizedBox(height: 32),
            HavingAccount(
              isLoading: isLoading,
              content: 'Already have an account?',
              title: 'Sign In',
              onTap: () => popNavigation(context),
            ),
          ]),
        ),
      ),
    ],
  );
}
