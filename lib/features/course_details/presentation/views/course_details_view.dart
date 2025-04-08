import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/features/course_details/presentation/views/widgets/course_details_view_body.dart'
    show CourseDetailsViewBody;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Scaffold,
        StatelessWidget,
        StreamBuilder,
        Widget;

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({required this.courseStream, super.key});
  final Stream<CourseEntity> courseStream;
  @override
  Widget build(BuildContext context) => StreamBuilder<CourseEntity>(
    stream: courseStream,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(body: CourseDetailsViewBody(course: snapshot.data!));
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    },
  );
}
