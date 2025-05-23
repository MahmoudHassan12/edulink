import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/features/home/presentation/views/widgets/current_courses.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/row_of_texts.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});
  @override
  RefreshIndicator build(BuildContext context) => RefreshIndicator(
    onRefresh: () async {
      await SharedPrefSingleton.reload();
    },
    child: CustomScrollView(
      slivers: [
        const HomeAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList.list(
          children: const [
            RowOfTexts(title: 'Your Courses'),
            CurrentCourses(),
          ],
        ),
      ],
    ),
  );
}
