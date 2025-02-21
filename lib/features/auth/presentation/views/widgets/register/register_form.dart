import 'dart:developer';

import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/navigations.dart';

import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({this.isLoading = false, super.key});
  final bool isLoading;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> signUp() async {
    if (!_formKey.currentState!.validate()) {
      return false; // Validation failed
    }

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      log("Passwords do not match");
      return false;
    }

    try {
      var user = await _auth.signUpWithEmail(email, password);
      if (user != null) {
        log("User registered successfully");
        return true;
      } else {
        log("Failed to register user");
        return false;
      }
    } catch (e) {
      log("Error: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            setVisible: (isVisible) {},
            textInputAction: TextInputAction.next,
            labelText: 'Password',
            onChanged: (value) {},
          ),
          PasswordTextField(
            isLoading: widget.isLoading,
            passwordController: _confirmPasswordController,
            setVisible: (isVisible) {},
            textInputAction: TextInputAction.go,
            labelText: 'Confirm Password',
          ),
          CustomFilledButton(
            label: 'Register',
            onPressed:
                widget.isLoading
                    ? null
                    : () async {
                      bool success = await signUp();
                      if (success) {
                        homeNavigation(context);
                      }
                    },
          ),
        ],
      ),
    );
  }
}
