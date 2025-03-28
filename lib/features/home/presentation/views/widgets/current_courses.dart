import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';

class CurrentCourses extends StatelessWidget {
  const CurrentCourses({super.key});
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 4 / 3,
    child: CarouselView(
      itemExtent: MediaQuery.sizeOf(context).width - 80,
      itemSnapping: true,
      enableSplash: false,
      children: // TODO(Anyone): Needs handling
          getUser?.courses?.map((course) => Course(course: course)).toList() ??
          [],
    ),
  );
}
