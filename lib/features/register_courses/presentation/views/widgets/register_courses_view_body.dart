import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_courses.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class RegisterCoursesViewBody extends StatefulWidget {
  const RegisterCoursesViewBody({super.key});
  @override
  State<RegisterCoursesViewBody> createState() =>
      _RegisterCoursesViewBodyState();
}

class _RegisterCoursesViewBodyState extends State<RegisterCoursesViewBody> {
  final List<CourseEntity> courses = [];
  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () async {
      await getCoursesMethod();
      setState(() {});
    },
    child: CustomScrollView(
      slivers: [
        const SliverAppBar(title: EText('Register Courses'), centerTitle: true),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.builder(
            itemCount: getCourses()?.length ?? 0,
            itemBuilder: (context, index) {
              final course = getCourses()?[index];
              return Card.filled(
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: const RoundedRectangleBorder(borderRadius: sBorder),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  leading: Hero(
                    tag: course!.imageUrl!,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        course.imageUrl!,
                      ),
                      radius: 20,
                    ),
                  ),
                  title: EText(course.code!),
                  subtitle: EText(course.title!),
                  trailing: ChooseCourse(courses: courses),
                  onTap:
                      () async =>
                          courseDetailsNavigation(context, extra: course),
                ),
              );
            },
          ),
        ),
        RegisterButton(courses: courses),
      ],
    ),
  );
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({required this.courses, super.key});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: CustomFilledButton(
        label: 'Register',
        onPressed: () async {
          //  _addCourses(courses.map((e) => e.toMap()).toList());
        },
      ),
    ),
  );
}

// Future<void> _addCourses(List<Map<String, dynamic>> courses) async =>
// UserRepo().update(data: {Endpoints.courses: FieldValue.arrayUnion(courses)});

class ChooseCourse extends StatefulWidget {
  const ChooseCourse({required this.courses, super.key});
  final List<CourseEntity> courses;
  @override
  State<ChooseCourse> createState() => _ChooseCourseState();
}

class _ChooseCourseState extends State<ChooseCourse> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) => Checkbox(
    value: _isSelected,
    onChanged: (value) {
      return value != null ? setState(() => _isSelected = !_isSelected) : null;
    },
  );
}
