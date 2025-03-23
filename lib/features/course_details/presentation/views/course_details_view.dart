import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/features/course_details/presentation/views/widgets/course_details_view_body.dart'
    show CourseDetailsViewBody;
import 'package:flutter/material.dart'
    show  BuildContext, Scaffold, StatelessWidget;

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({required this.course, super.key});
  final CourseEntity course;
  @override
  Scaffold build(BuildContext context) =>
      Scaffold(body: CourseDetailsViewBody(course: course));
}
