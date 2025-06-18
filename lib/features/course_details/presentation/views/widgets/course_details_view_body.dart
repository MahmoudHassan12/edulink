import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/course_image.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsViewBody extends StatelessWidget {
  const CourseDetailsViewBody({required this.course, super.key});
  final CourseEntity course;

  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        title: const EText('Course Details'),
        centerTitle: true,
        floating: true,
        snap: true,
        actions: (getUser?.isProfessor ?? false)
            ? [
                IconButton(
                  onPressed: () =>
                      manageCourseNavigation(context, extra: course),
                  icon: const Icon(Icons.edit_rounded),
                ),
              ]
            : [
                IconButton(
                  onPressed: () => withdrawCourse(context),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  tooltip: 'Withdraw',
                ),
              ],
      ),
      SliverToBoxAdapter(
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: CourseImage(imageUrl: course.imageUrl!),
        ),
      ),
      SliverToBoxAdapter(
        child: ListTile(
          title: EText(course.code!),
          subtitle: EText('${course.title}\nBy Dr. ${course.professor?.name}'),
          trailing: IconButton.filledTonal(
            onPressed: () => qAForumNavigation(context, extra: course),
            icon: const Icon(Icons.forum_rounded),
            style: const ButtonStyle(iconSize: WidgetStatePropertyAll(40)),
            tooltip: 'Q&A Forum',
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const Divider(),
            const SizedBox(height: 8),
            EText(course.description ?? 'No description available.'),
            const SizedBox(height: 16),
            CustomFilledButton.icon(
              onPressed: () => contentNavigation(context, extra: course.id),
              icon: Icons.folder_rounded,
              label: 'Course Content',
            ),
            const SizedBox(height: 16),
            CustomFilledButton.icon(
              onPressed: () =>
                  registeredUsersNavigation(context, extra: course.id!),
              icon: Icons.people_rounded,
              label: 'Registered Users',
            ),
          ],
        ),
      ),
    ],
  );

  Future<void> withdrawCourse(BuildContext context) async {
    final UserEntity? user = getUser;
    final List<String>? courseList = getUser!.coursesIds;

    await const UserRepo().update(
      data: getUser!
          .copyWith(coursesIds: courseList?..remove(course.id))
          .toMap(),
      documentId: getUser!.id!,
    );
    if (user == null || course.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User or course data is missing.')),
      );
      return;
    }

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have withdrawn from the course.'),
          backgroundColor: Colors.green,
        ),
      );

      homeNavigation(context);
      await context.read<HomeCubit>().getCourses();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to withdraw: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
