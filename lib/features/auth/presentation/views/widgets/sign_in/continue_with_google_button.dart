import 'dart:developer';

import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  const ContinueWithGoogleButton({required this.isLoading, super.key});
  final bool isLoading;

  Future<void> handleGoogleSignIn(BuildContext context) async {
    log('Google Sign-In button pressed'); // Check if this prints when clicked
    var user = await AuthService().signInWithGoogle();
    if (user != null) {
      log('Google Sign-In successful: ${user.email}');
      await homeNavigation(context);
    } else {
      log('Google Sign-In failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInWithProviderButton(
      label: 'Continue with Google',
      isLoading: isLoading,
      onPressed: isLoading ? null : () async => handleGoogleSignIn(context),
      iconData: FontAwesomeIcons.google,
    );
  }
}
