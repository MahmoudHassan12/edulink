import 'dart:developer';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart' show AuthRepo;
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  const ContinueWithGoogleButton({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => SignInWithProviderButton(
    label: 'Continue with Google',
    isLoading: isLoading,
    onPressed: () async => _handleGoogleSignIn(context),
    iconData: FontAwesomeIcons.google,
  );
}

Future<void> _handleGoogleSignIn(BuildContext context) async {
  log('Google Sign-In button pressed'); // Check if this prints when clicked
  final user = await const AuthRepo().signInWithGoogle();
  if (user != null && context.mounted) {
    log('Google Sign-In successful: ${user.email}');
    await homeNavigation(context);
  } else {
    log('Google Sign-In failed');
  }
}
