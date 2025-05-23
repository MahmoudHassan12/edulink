import 'dart:developer';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  var _isVisible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> _signUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return false; // Validation failed
    }

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      log('Passwords do not match');
      return false;
    }

    try {
      await const AuthRepo().signUpWithEmail(email, password);
      log('User registered successfully');
      return true;
    } on Exception catch (e) {
      log('Error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: [
        EmailTextField(
          isLoading: widget.isLoading,
          emailController: _emailController,
          textInputAction: TextInputAction.next,
          onChanged: (value) {},
        ),
        PasswordTextField(
          isLoading: widget.isLoading,
          passwordController: _passwordController,
          isVisible: _isVisible,
          setVisible: (isVisible) => setState(() => _isVisible = isVisible),
          textInputAction: TextInputAction.next,
          labelText: 'Password',
          onChanged: (value) {},
        ),
        PasswordTextField(
          isLoading: widget.isLoading,
          passwordController: _confirmPasswordController,
          isVisible: _isVisible,
          setVisible: (isVisible) => setState(() => _isVisible = isVisible),
          textInputAction: TextInputAction.go,
          labelText: 'Confirm Password',
        ),
        CustomFilledButton(
          label: 'Register',
          onPressed: widget.isLoading
              ? null
              : () async {
                  if (await _signUp() && context.mounted) {
                    await manageProfileNavigation(context);
                  }
                },
        ),
      ],
    ),
  );
}
