import 'package:edu_link/features/auth/presentation/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget, Text;

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Register')),
    body: const RegisterViewBody(),
  );
}
