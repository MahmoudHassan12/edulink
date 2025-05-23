import 'package:edu_link/features/course_details/presentation/controllers/registered_users_cubit/registered_users_cubit.dart'
    show RegisteredUsersCubit;
import 'package:edu_link/features/course_details/presentation/views/widgets/registered_users_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class RegisteredUsersView extends StatelessWidget {
  const RegisteredUsersView({required this.courseId, super.key});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisteredUsersCubit(courseId),
      child: const Scaffold(body: RegisteredUsersViewBody()),
    );
  }
}
