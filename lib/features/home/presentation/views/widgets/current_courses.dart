import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart'
    show HomeCubit, HomeFailure, HomeLoading, HomeState, HomeSuccess;
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;

class CurrentCourses extends StatelessWidget {
  const CurrentCourses({super.key});
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 4 / 3,
    child: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          if (state.courses?.isNotEmpty ?? false) {
            return CarouselView(
              itemExtent: MediaQuery.sizeOf(context).width - 80,
              itemSnapping: true,
              enableSplash: false,
              children: state.courses!
                  .map((course) => Course(course: course))
                  .toList(),
            );
          }
          return const Center(child: Text('No courses available'));
        }
        if (state is HomeFailure) {
          return Center(child: Text(state.message));
        }
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('No courses available'));
      },
    ),
  );
}
