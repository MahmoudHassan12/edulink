import 'package:edu_link/features/auth/presentation/views/widgets/signin_view_body.dart'
    show SigninViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget, Text;

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sign In')),
    body: const SigninViewBody(),
  );
}
