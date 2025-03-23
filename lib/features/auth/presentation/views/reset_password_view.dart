import 'package:edu_link/features/auth/presentation/views/widgets/reset_password/reset_password_view_body.dart'
    show ResetPasswordViewBody;
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  @override
  Scaffold build(BuildContext context) =>
      const Scaffold(body: ResetPasswordViewBody());
}
