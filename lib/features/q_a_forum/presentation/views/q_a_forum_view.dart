import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_view_body.dart'
    show QAForumViewBody;
import 'package:flutter/material.dart'
    show BuildContext, Scaffold, StatelessWidget;

class QAForumView extends StatelessWidget {
  const QAForumView({required this.course, super.key});
  final CourseEntity course;
  @override
  Scaffold build(BuildContext context) =>
      Scaffold(body: QAForumViewBody(course: course));
}
