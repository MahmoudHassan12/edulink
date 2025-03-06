import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/widgets/course_image.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/favorite_button.dart' show FavoriteButton;
import 'package:flutter/material.dart';

class CourseDetailsViewBody extends StatelessWidget {
  const CourseDetailsViewBody({required this.course, super.key});
  final CourseEntity course;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      const SliverAppBar(
        title: EText('Course Details'),
        centerTitle: true,
        floating: true,
        snap: true,
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      SliverToBoxAdapter(
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: CourseImage(imageUrl: course.imageUrl!),
        ),
      ),
      SliverToBoxAdapter(
        child: ListTile(
          title: EText(course.code!),
          subtitle: EText('${course.title}\nBy ${course.professor?.name}'),
          trailing: const FavoriteButton(),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const Divider(),
            const SizedBox(height: 8),
            EText(course.description!),
          ],
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 1600)),
    ],
  );
}
