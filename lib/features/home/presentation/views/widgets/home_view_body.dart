import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/user_repo.dart';
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
    onRefresh: () => const UserRepo()
        .getFromFireStore(documentId: getUser!.id!)
        .then((user) => const UserRepo().udateLocal(user!.toMap()))
        .then(
          (_) =>
              context.mounted ? context.read<HomeCubit>().getCourses() : null,
        ),
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
