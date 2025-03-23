import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart';
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;

class CurrentCourses extends StatelessWidget {
  const CurrentCourses({super.key});
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 4 / 3,
    child: BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        if (state is CoursesFailure) {
          return Center(child: Text(state.message));
        }
        if (state is CoursesSuccess) {
          return CarouselView(
            itemExtent: MediaQuery.sizeOf(context).width - 80,
            itemSnapping: true,
            enableSplash: false,
            children: // TODO(Anyone): Needs handling
                state.courses.map((course) => Course(course: course)).toList(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ),
  );
}
