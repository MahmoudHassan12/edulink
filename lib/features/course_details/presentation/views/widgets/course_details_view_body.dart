import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:flutter/material.dart';

class CourseDetailsViewBody extends StatelessWidget {
  const CourseDetailsViewBody({required this.course, super.key});
  final CourseEntity course;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar.large(
        title: EText(course.title!),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: CachedNetworkImage(
            imageUrl: course.imageUrl!,
            fit: BoxFit.fitWidth,
          ),
          centerTitle: true,
        ),
        expandedHeight: 500,
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 1600)),
    ],
  );
}
