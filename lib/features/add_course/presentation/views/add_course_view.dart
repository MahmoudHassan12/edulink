import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/add_course/presentation/views/widgets/add_course_view_body.dart'
    show AddCourseViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget;

class AddCourseView extends StatelessWidget {
  const AddCourseView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const EText('Add Course')),
    body: const AddCourseViewBody(),
  );
}
