import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/features/home/presentation/views/widgets/current_courses.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/row_of_texts.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  Future<void> refresh() async =>
      const UserRepo().get().then((_) => setState(() {}));
  @override
  RefreshIndicator build(BuildContext context) => RefreshIndicator(
    onRefresh: refresh,
    child: CustomScrollView(
      slivers: [
        const HomeAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList.list(
          children: [
            const RowOfTexts(title: 'Your Courses'),
            CurrentCourses(key: widget.key),
            const SizedBox(height: 400),
          ],
        ),
      ],
    ),
  );
}
