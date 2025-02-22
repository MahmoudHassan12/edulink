import 'dart:developer';

import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/forgot_password.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({this.isLoading = false, super.key});
  final bool isLoading;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        log('Sign-in successful: ${user.uid}');
        if (mounted) {
          await homeNavigation(context);
        }
      } else {
        log('Sign-in failed');
      }
    } catch (e) {
      log('Sign-in Error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailTextField(
            isLoading: _isLoading,
            emailController: _emailController,
            textInputAction: TextInputAction.next,
          ),
          PasswordTextField(
            isLoading: _isLoading,
            passwordController: _passwordController,
            textInputAction: TextInputAction.go,
            labelText: 'Password',
          ),
          ForgotPassword(isLoading: _isLoading),
          CustomFilledButton(
            label: 'Sign In',
            onPressed: _isLoading ? null : _signIn,
          ),
        ],
      ),
    );
  }
}
