import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';

class CurrentCourses extends StatelessWidget {
  const CurrentCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserEntity?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: EText('Error: ${snapshot.error}'));
        }
        final user = snapshot.data;
        if (user == null || (user.courses?.isEmpty ?? true)) {
          return const Center(child: EText('No courses available'));
        }
        return AspectRatio(
          aspectRatio: 4 / 3,
          child: CarouselView(
            itemExtent: MediaQuery.sizeOf(context).width - 80,
            itemSnapping: true,
            enableSplash: false,
            children:
                user.courses!.map((course) => Course(course: course)).toList(),
          ),
        );
      },
    );
  }
}
