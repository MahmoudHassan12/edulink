import 'package:edu_link/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/reset_password/reset_password_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    body: BlocProvider<AuthCubit>.value(
      value: BlocProvider.of<AuthCubit>(context),
      child: const ResetPasswordViewBodyBlocConsumer(),
    ),
  );
}
