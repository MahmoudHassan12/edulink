import 'dart:developer';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart' show AuthRepo;
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithFacebookButton extends StatelessWidget {
  const ContinueWithFacebookButton({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => SignInWithProviderButton(
    label: 'Continue with Facebook',
    isLoading: isLoading,
    onPressed: () async => _handleFacebookSignIn(context),
    iconData: FontAwesomeIcons.facebook,
  );
}

Future<void> _handleFacebookSignIn(BuildContext context) async {
  log('Facebook Sign-In button pressed'); // Check if this prints when clicked
  final user = await const AuthRepo().signInWithFacebook();
  if (user != null && context.mounted) {
    log('Facebook Sign-In successful: ${user.email}');
    await homeNavigation(context);
  } else {
    log('Facebook Sign-In failed');
  }
}
