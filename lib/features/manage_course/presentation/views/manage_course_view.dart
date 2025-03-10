import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/manage_course_view_body.dart'
    show ManageCourseViewBody;
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Icon,
        IconButton,
        Icons,
        Scaffold,
        StatelessWidget;

class ManageCourseView extends StatelessWidget {
  const ManageCourseView({super.key, this.course});
  final CourseEntity? course;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: EText(course == null ? 'Add Course' : 'Edit Course'),
      centerTitle: true,
      actions:
          course == null
              ? null
              : [
                IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () {
                    // TODO(Mahmoud): Create a method to delete a course
                  },
                ),
              ],
    ),
    body: ManageCourseViewBody(course: course),
  );
}
