import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return AppSearchAnchor(courses: state.courses);
        }
        return const AppSearchAnchor();
      },
    ),
  );
  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class AppSearchAnchor extends StatelessWidget {
  const AppSearchAnchor({super.key, this.courses});
  final List<CourseEntity>? courses;

  @override
  Widget build(BuildContext context) => SearchAnchor.bar(
    suggestionsBuilder: (context, controller) =>
        _suggestions(context, courses, controller),
    viewHintText: 'Search',
    barHintText: 'Search',
    barShape: const WidgetStatePropertyAll(
      RoundedSuperellipseBorder(borderRadius: xsBorder),
    ),
    constraints: const BoxConstraints(minHeight: 48),
    barElevation: const WidgetStatePropertyAll(0),
  );
}

Iterable<ListTile> _suggestions(
  BuildContext context,
  List<CourseEntity>? courses,
  SearchController controller,
) sync* {
  final String searchQuery = controller.value.text.toLowerCase();
  if (searchQuery.isEmpty) {
    return;
  }
  for (final CourseEntity course in (courses ?? <CourseEntity>[])) {
    final String? courseTitle = course.title;
    final String? courseCode = course.code;
    if ((courseTitle?.toLowerCase().contains(searchQuery) ?? false) ||
        (courseCode?.toLowerCase().contains(searchQuery) ?? false)) {
      yield ListTile(
        title: Text(courseCode!),
        subtitle: Text(courseTitle!),
        onTap: () => courseDetailsNavigation(context, extra: course).then(
          (_) => controller
            ..clear()
            ..closeView(null),
        ),
      );
    }
  }
}
