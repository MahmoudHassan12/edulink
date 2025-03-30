import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart'
    show HomeCubit, HomeState;
import 'package:edu_link/features/home/presentation/views/widgets/current_courses.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/row_of_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  Future<void> refresh() async => const UserRepo()
      .get(documentId: getUser!.id!)
      .then((_) => setState(() {}));
  @override
  RefreshIndicator build(BuildContext context) => RefreshIndicator(
    onRefresh: () async {
      await context.read<HomeCubit>().getInitialData();
      setState(() {});
    },
    child: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomScrollView(
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
        );
      },
    ),
  );
}
