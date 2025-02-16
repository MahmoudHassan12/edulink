import 'package:edu_link/features/auth/presentation/views/widgets/reset_password_view_body.dart'
    show ResetPasswordViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget, Text;

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Reset Password')),
    body: const ResetPasswordViewBody(),
  );
}
