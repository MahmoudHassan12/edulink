import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:flutter/material.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SearchAnchor.bar(
      suggestionsBuilder:
          (context, controller) =>
              _suggestions(context, getUser?.courses, controller),
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
  );
  @override
  Size get preferredSize => const Size.fromHeight(48);
}

Iterable<ListTile> _suggestions(
  BuildContext context,
  List<CourseEntity>? courses,
  SearchController controller,
) sync* {
  final searchQuery = controller.value.text.toLowerCase();
  if (searchQuery.isEmpty) return;
  for (final course in (courses ?? <CourseEntity>[])) {
    final courseTitle = course.title;
    final courseCode = course.code;
    if ((courseTitle?.toLowerCase().contains(searchQuery) ?? false) ||
        (courseCode?.toLowerCase().contains(searchQuery) ?? false)) {
      yield ListTile(
        title: Text(courseCode!),
        subtitle: Text(courseTitle!),
        onTap:
            () async => courseDetailsNavigation(context, extra: course).then(
              (_) =>
                  controller
                    ..clear()
                    ..closeView(null),
            ),
      );
    }
  }
}
