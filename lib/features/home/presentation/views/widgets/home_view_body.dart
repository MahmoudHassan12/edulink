import 'package:edu_link/features/home/presentation/views/widgets/current_courses.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/row_of_texts.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      const HomeAppBar(),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      SliverList.list(
        children: [
          const RowOfTexts(title: 'Your Courses'),
          CurrentCourses(),
          const SizedBox(height: 16),
        ],
      ),
    ],
  );
}
