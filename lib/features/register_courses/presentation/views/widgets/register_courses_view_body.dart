import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/widgets/app_search_anchor.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart'
    show HomeCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

class RegisterCoursesViewBody extends StatefulWidget {
  const RegisterCoursesViewBody({super.key});
  @override
  State<RegisterCoursesViewBody> createState() =>
      _RegisterCoursesViewBodyState();
}

class _RegisterCoursesViewBodyState extends State<RegisterCoursesViewBody> {
  final List<String> selectedCourses = [...?getUser?.coursesIds];
  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () async {
      await context.read<CoursesCubit>().getCourses();
      setState(() {});
    },
    child: CustomScrollView(
      slivers: [
        const SliverAppBar.medium(
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.5),
            child: EText('Register Courses'),
          ),
          centerTitle: true,
          bottom: AppBarBottom(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          sliver: BlocBuilder<CoursesCubit, CoursesState>(
            builder: (context, state) {
              if (state is CoursesFailure) {
                return SliverFillRemaining(
                  child: Center(child: EText(state.message)),
                );
              }
              if (state is CoursesSuccess) {
                return SliverList.builder(
                  itemCount: state.courses.length,
                  itemBuilder: (context, index) {
                    final CourseEntity course = state.courses[index];
                    return Card.filled(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: const RoundedSuperellipseBorder(
                        borderRadius: sBorder,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        leading: Hero(
                          tag: course.imageUrl!,
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              course.imageUrl!,
                            ),
                            radius: 20,
                          ),
                        ),
                        title: EText(course.code!),
                        subtitle: EText(course.title!),
                        trailing: ChooseCourse(
                          courseId: course.id!,
                          selectedCourses: selectedCourses,
                          onSelectionChanged: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                selectedCourses.add(course.id!);
                              } else {
                                selectedCourses.remove(course.id);
                              }
                            });
                          },
                        ),
                        onTap: () =>
                            courseDetailsNavigation(context, extra: course),
                      ),
                    );
                  },
                );
              }
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
        RegisterButton(selectedCourses: selectedCourses),
      ],
    ),
  );
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({required this.selectedCourses, super.key});
  final List<String> selectedCourses;
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: CustomFilledButton(
        label: 'Register',
        onPressed: () async {
          await const UserRepo().update(
            data: getUser!.copyWith(coursesIds: selectedCourses).toMap(),
            documentId: getUser!.id!,
          );
          if (context.mounted) {
            await context.read<HomeCubit>().getCourses();
          }
          if (context.mounted) {
            popNavigation(context);
          }
        },
      ),
    ),
  );
}

class ChooseCourse extends StatelessWidget {
  const ChooseCourse({
    required this.courseId,
    required this.selectedCourses,
    required this.onSelectionChanged,
    super.key,
  });
  final String courseId;
  final List<String> selectedCourses;
  final ValueChanged<bool> onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    final List<String?>? registeredCoursesIds = getUser?.coursesIds;
    return Checkbox(
      shape: const RoundedSuperellipseBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      value:
          (registeredCoursesIds?.contains(courseId) ?? false) ||
          selectedCourses.contains(courseId),
      onChanged: registeredCoursesIds?.contains(courseId) ?? false
          ? null
          : (value) {
              if (value != null) {
                onSelectionChanged(value);
              }
            },
    );
  }
}

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        if (state is CoursesSuccess) {
          return AppSearchAnchor(courses: state.courses);
        }
        return const AppSearchAnchor();
      },
    ),
  );
  @override
  Size get preferredSize => const Size.fromHeight(48);
}
