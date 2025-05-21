import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/course_image.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:flutter/material.dart';

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
                  onPressed: () async =>
                      manageCourseNavigation(context, extra: course),
                  icon: const Icon(Icons.edit_rounded),
                ),
              ]
            : null,
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
          subtitle: EText('${course.title}\nBy Dr ${course.professor?.name}'),
          trailing: IconButton(
            onPressed: () async => qAForumNavigation(context, extra: course),
            icon: const Icon(Icons.message_rounded),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const Divider(),
            const SizedBox(height: 8),
            EText(course.description!),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async =>
                  contentNavigation(context, extra: course.id),
              icon: const Icon(Icons.folder_rounded),
              label: const Text('Course Content'),
              style: ElevatedButton.styleFrom(
                shape: RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 1600)),
    ],
  );
}
