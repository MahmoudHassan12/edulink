import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_with_provider_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithFacebookButton extends StatelessWidget {
  const ContinueWithFacebookButton({required this.isLoading, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => SignInWithProviderButton(
    label: 'Continue with Facebook',
    isLoading: isLoading,
    onPressed: () {},
    iconData: FontAwesomeIcons.facebook,
  );
}
