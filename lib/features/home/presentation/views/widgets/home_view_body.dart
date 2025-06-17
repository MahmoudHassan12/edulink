import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart'
    show HomeCubit;
import 'package:edu_link/features/home/presentation/views/widgets/current_courses.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/row_of_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});
  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => context.read<HomeCubit>().getCourses(),
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
