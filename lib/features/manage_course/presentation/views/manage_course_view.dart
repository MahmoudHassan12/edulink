import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/manage_course_view_body.dart'
    show ManageCourseViewBody;
import 'package:flutter/material.dart';

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
                  onPressed:
                      () async => deleteCourseDialog(context, path: course?.id),
                ),
              ],
    ),
    body: ManageCourseViewBody(course: course),
  );
}

Future<void> deleteCourseDialog(BuildContext context, {String? path}) =>
    showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
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
      (value) =>
          value ?? false
              ? _deleteFromFirestore(collectionPath: 'courses', path: path)
              : null,
    );

Future<void> _deleteFromFirestore({
  required String collectionPath,
  String? path,
}) => FirebaseFirestore.instance
    .collection(collectionPath)
    .doc(path)
    .delete()
    .then((_) => log('Course deleted successfully!'))
    .catchError((e) => log('Failed to delete course: $e'));
