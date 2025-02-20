import 'package:edu_link/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/reset_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordViewBodyBlocConsumer extends StatelessWidget {
  const ResetPasswordViewBodyBlocConsumer({super.key});
  @override
  BlocListener<AuthCubit, AuthState> build(BuildContext context) {
    var isLoading = false;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          isLoading = true;
        } else if (state is AuthSuccess) {
          isLoading = false;
        } else if (state is AuthFailure) {
          isLoading = false;
        }
      },
      child: ResetPasswordViewBody(isLoading: isLoading),
    );
  }
}
