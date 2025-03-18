import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/manage_user/presentation/views/widgets/manage_profile_view_body.dart'
    show ManageProfileViewBody;
import 'package:flutter/material.dart';

class ManageProfileView extends StatelessWidget {
  const ManageProfileView({super.key, this.user});
  final UserEntity? user;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: EText(user == null ? 'Add User' : 'Edit User'),
      centerTitle: true,
      // actions:
      //     user == null
      //         ? null
      //         : [
      //           IconButton(
      //             icon: const Icon(Icons.delete_rounded),
      //             onPressed:
      //                 () async =>
      //                     _deleteCourseDialog(context, documentId: user?.id),
      //           ),
      //         ],
    ),
    body: ManageProfileViewBody(user: user),
  );
}

// ignore: unused_element
Future<void> _deleteCourseDialog(BuildContext context, {String? documentId}) =>
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
              ? const CoursesRepo().delete(documentId: documentId)
              : null,
    );
