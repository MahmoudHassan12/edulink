import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/manage_course/presentation/controllers/manage_course_cubit/manage_course_cubit.dart'
    show ManageCourseCubit;
import 'package:edu_link/features/manage_course/presentation/views/widgets/manage_course_view_body.dart'
    show ManageCourseViewBody;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class ManageCourseView extends StatelessWidget {
  const ManageCourseView({super.key, this.course});
  final CourseEntity? course;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: EText(course == null ? 'Add Course' : 'Edit Course'),
      centerTitle: true,
      actions: course == null
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () async =>
                    _deleteCourseDialog(context, documentId: course!.id!),
              ),
            ],
    ),
    body: BlocProvider<ManageCourseCubit>(
      create: (context) => ManageCourseCubit(),
      child: ManageCourseViewBody(course: course),
    ),
  );
}

Future<void> _deleteCourseDialog(
  BuildContext context, {
  required String documentId,
}) =>
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const EText('Delete Course'),
        content: const EText(
          'Are you sure you want to delete this course?',
          softWrap: true,
        ),
        actions: [
          TextButton(
            child: const EText('Cancel'),
            onPressed: () => popNavigation(context, false),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const EText('Delete'),
            onPressed: () => popNavigation(context, true),
          ),
        ],
      ),
    ).then(
      (value) => value ?? false
          ? const CoursesRepo().delete(documentId: documentId)
          : null,
    );
