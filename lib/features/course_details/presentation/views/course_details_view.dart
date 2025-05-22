import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/features/course_details/presentation/controllers/registered_users_cubit/registered_users_cubit.dart'
    show RegisteredUsersCubit;
import 'package:edu_link/features/course_details/presentation/views/widgets/course_details_view_body.dart'
    show CourseDetailsViewBody;
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart'
    show BuildContext, Center, Scaffold, StatelessWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocSelector;

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({required this.course, super.key});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocSelector<HomeCubit, HomeState, CourseEntity?>(
      selector: (state) {
        if (state is HomeSuccess) {
          return state.courses?.firstWhere(
            (e) => e.id == course.id,
            orElse: () => course,
          );
        }
        return null;
      },
      builder: (_, course) {
        if (course == null) {
          return const Center(child: Text('Course not found'));
        }
        return BlocProvider(
          create: (context) => RegisteredUsersCubit(course.id!),
          child: CourseDetailsViewBody(course: course),
        );
      },
    ),
  );
}
