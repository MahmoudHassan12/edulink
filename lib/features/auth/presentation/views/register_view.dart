import 'package:edu_link/features/auth/presentation/views/widgets/register/register_view_body.dart'
    show RegisterViewBody;
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Scaffold build(BuildContext context) =>
      const Scaffold(body: RegisterViewBody());
}
