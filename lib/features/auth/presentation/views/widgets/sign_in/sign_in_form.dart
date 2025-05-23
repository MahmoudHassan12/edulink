import 'dart:developer';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart';
import 'package:edu_link/core/repos/courses_repo.dart' show CoursesRepo;
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  Future<void> handleSignInSuccess() async {
    await const CoursesRepo().getAll();
    if (mounted) {
      await homeNavigation(context);
    }
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final User? user = await const AuthRepo().signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        log('Sign-in successful: ${user.uid}');

        if (mounted) {
          showSnackbar(context, 'Welcome back!');
          await handleSignInSuccess();
        }
      } else {
        log('Sign-in failed');
        if (mounted) {
          showSnackbar(
            context,
            'Sign-in failed. Please try again.',
            flag: false,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      log('Sign-in Error: $e');
      if (mounted) {
        showSnackbar(context, 'An error occurred: $e', flag: false);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Form(
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

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
  BuildContext context,
  String message, {
  bool flag = true,
}) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
    backgroundColor: flag ? Colors.green[500] : Colors.red[500],
    duration: const Duration(seconds: 3),
  ),
);
