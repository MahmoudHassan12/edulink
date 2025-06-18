import 'package:cloud_firestore/cloud_firestore.dart';
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
  const ManageCourseView({required this.course, super.key});
  final CourseEntity course;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: EText(!course.isValid ? 'Add Course' : 'Edit Course'),
      centerTitle: true,
      actions: !course.isValid
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () =>
                    _deleteCourseDialog(context, documentId: course.id!),
              ),
            ],
    ),
    body: BlocProvider<ManageCourseCubit>(
      create: (context) => ManageCourseCubit(course),
      child: ManageCourseViewBody(course: course),
    ),
  );
}

Future<void> _deleteCourseDialog(
  BuildContext context, {
  required String documentId,
}) async {
  final bool? confirm = await showDialog<bool>(
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
  );

  if (confirm ?? false) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot<Map<String, dynamic>> usersSnapshot = await firestore
        .collection('users')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in usersSnapshot.docs) {
      final List<dynamic> coursesIds = doc.data()['coursesIds'] ?? [];

      if (coursesIds.contains(documentId)) {
        coursesIds.remove(documentId);

        await firestore.collection('users').doc(doc.id).update({
          'coursesIds': coursesIds,
        });
      }
    }

    await const CoursesRepo().delete(documentId: documentId);
  }
}

/*
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
    ).then((value) {
      if (value ?? false) {
        FirebaseFirestore.instance.collection("users").doc(getUser?.id);

        return const CoursesRepo().delete(documentId: documentId);
      }
    });
*/
