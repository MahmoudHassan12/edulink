import 'package:edu_link/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    body: BlocProvider<AuthCubit>.value(
      value: BlocProvider.of<AuthCubit>(context),
      child: const SignInViewBodyBlocConsumer(),
    ),
  );
}
