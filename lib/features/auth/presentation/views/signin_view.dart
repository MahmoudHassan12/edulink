import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_view_body.dart' show SignInViewBody;
import 'package:flutter/material.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  @override
  Scaffold build(BuildContext context) =>
      const Scaffold(body: SignInViewBody());
}
