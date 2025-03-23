import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart'
    show CoursesCubit, CoursesState, CoursesSuccess;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: BlocBuilder<CoursesCubit, CoursesState>(
      builder:
          (context, state) => SearchAnchor.bar(
            suggestionsBuilder:
                (_, controller) =>
                    state is CoursesSuccess
                        ? suggestions(state.courses, controller)
                        : [],
            viewHintText: 'Search',
            barHintText: 'Search',
            viewTrailing: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
            barShape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: xsBorder),
            ),
            constraints: const BoxConstraints(minHeight: 48),
            barElevation: const WidgetStatePropertyAll(0),
          ),
    ),
  );
  @override
  Size get preferredSize => const Size.fromHeight(48);
}

Iterable<ListTile> suggestions(
  List<CourseEntity> courses,
  SearchController controller,
) sync* {
  final query = controller.value.text.toLowerCase();
  final queryWords = query.split(' ');
  for (final course in courses) {
    final title = course.title?.toLowerCase();
    final code = course.code?.toLowerCase();
    if ((title?.contains(query) ?? false) ||
        (code?.contains(query) ?? false) ||
        queryWords.any(
          (element) =>
              (title?.contains(element) ?? false) ||
              (code?.contains(element) ?? false),
        )) {
      yield ListTile(
        title: Text(course.code ?? ''),
        subtitle: Text(course.title ?? ''),
        onTap: () {},
      );
    }
  }
}
