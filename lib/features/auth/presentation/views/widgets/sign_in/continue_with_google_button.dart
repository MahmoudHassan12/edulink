import 'dart:developer';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart' show AuthRepo;
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  const ContinueWithGoogleButton({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => SignInWithProviderButton(
    label: 'Continue with Google',
    isLoading: isLoading,
    onPressed: () => _handleGoogleSignIn(context),
    iconData: FontAwesomeIcons.google,
  );
}

Future<void> _handleGoogleSignIn(BuildContext context) async {
  final User? user = await const AuthRepo().signInWithGoogle();
  if (user != null && context.mounted) {
    log('Google Sign-In successful: ${user.email}');
    getUser?.isValid ?? false
        ? await homeNavigation(context)
        : await manageProfileNavigation(context);
  } else {
    log('Google Sign-In failed');
  }
}
