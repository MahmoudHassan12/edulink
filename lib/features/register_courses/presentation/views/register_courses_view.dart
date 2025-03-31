import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart'
    show CoursesCubit;
import 'package:edu_link/features/register_courses/presentation/views/widgets/register_courses_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class RegisterCoursesView extends StatelessWidget {
  const RegisterCoursesView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider<CoursesCubit>(
      create: (context) => CoursesCubit(),
      child: const RegisterCoursesViewBody(),
    ),
  );
}
