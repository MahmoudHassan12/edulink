import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/forgot_password.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => Form(
    child: Column(
      children: [
        EmailTextField(
          isLoading: isLoading,
          textInputAction: TextInputAction.next,
        ),
        PasswordTextField(
          isLoading: isLoading,
          textInputAction: TextInputAction.go,
          labelText: 'Password',
        ),
        ForgotPassword(isLoading: isLoading),
        CustomFilledButton(
          label: 'Sign In',
          onPressed: isLoading ? null : () {},
        ),
      ],
    ),
  );
}
