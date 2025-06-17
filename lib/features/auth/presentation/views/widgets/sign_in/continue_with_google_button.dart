import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/auth_repo.dart' show AuthRepo;
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  const ContinueWithGoogleButton({
    required this.setIsLoading,
    this.isLoading = false,
    super.key,
  });
  final bool isLoading;
  //
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool isLoading) setIsLoading;

  @override
  Widget build(BuildContext context) => SignInWithProviderButton(
    label: 'Continue with Google',
    isLoading: isLoading,
    onPressed: () async {
      setIsLoading(true);
      final User? user = await const AuthRepo().signInWithGoogle();
      if (user != null && context.mounted) {
        setIsLoading(false);
        getUser?.isValid ?? false
            ? homeNavigation(context)
            : await manageProfileNavigation(context);
      } else {
        setIsLoading(false);
      }
    },
    iconData: FontAwesomeIcons.google,
  );
}
