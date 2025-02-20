import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/register/register_view_body.dart';
import 'package:flutter/material.dart' show BuildContext, StatelessWidget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;

class RegisterViewBlocConsumer extends StatelessWidget {
  const RegisterViewBlocConsumer({super.key});
  @override
  BlocListener<AuthCubit, AuthState> build(BuildContext context) {
    var isLoading = false;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          isLoading = true;
        } else if (state is AuthSuccess) {
          isLoading = false;
          await homeNavigation(context);
        } else if (state is AuthFailure) {
          isLoading = false;
        }
      },
      child: RegisterViewBody(isLoading: isLoading),
    );
  }
}
