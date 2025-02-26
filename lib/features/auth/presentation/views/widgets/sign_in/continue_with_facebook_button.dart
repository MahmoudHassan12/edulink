import 'dart:developer';

import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithFacebookButton extends StatelessWidget {
  const ContinueWithFacebookButton({required this.isLoading, super.key});
  final bool isLoading;

  Future<void> handleFacebookSignIn(BuildContext context) async {
    log('Facebook Sign-In button pressed'); // Check if this prints when clicked
    var user = await AuthService().signInWithFacebook();
    if (user != null) {
      log('Facebook Sign-In successful: ${user.email}');
      await homeNavigation(context);
    } else {
      log('Facebook Sign-In failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInWithProviderButton(
      label: 'Continue with Facebook',
      isLoading: isLoading,
      onPressed: isLoading ? null : () async => handleFacebookSignIn(context),
      iconData: FontAwesomeIcons.facebook,
    );
  }
}
