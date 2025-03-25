import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/constants/endpoints.dart';
import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

class RegisterCoursesViewBody extends StatefulWidget {
  const RegisterCoursesViewBody({super.key});
  @override
  State<RegisterCoursesViewBody> createState() =>
      _RegisterCoursesViewBodyState();
}

class _RegisterCoursesViewBodyState extends State<RegisterCoursesViewBody> {
  final Set<String> selectedCourses = {};

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () async {
      await context.read<CoursesCubit>().getCourses();
      setState(() {});
    },
    child: CustomScrollView(
      slivers: [
        const SliverAppBar(title: EText('Register Courses'), centerTitle: true),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    final course = state.courses[index];
                    return Card.filled(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: const RoundedRectangleBorder(
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
                                selectedCourses.remove(course.id!);
                              }
                            });
                          },
                        ),
                        onTap:
                            () async =>
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
  final Set<String> selectedCourses;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: CustomFilledButton(
        label: 'Register',
        onPressed: () async {
          await _registerCourses(selectedCourses);
          await homeNavigation(context);
        },
      ),
    ),
  );

  Future<void> _registerCourses(Set<String> courseIds) async {
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;

    if (userId == null) return;

    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await userRef.update({
      'courses': FieldValue.arrayUnion(courseIds.toList()),
    });
    // await _addCourses(courses);
  }
}

/* 
Future<void> _addCourses(List<Map<String, dynamic>> courses) async => UserRepo()
    .update(data: {Endpoints.courses: FieldValue.arrayUnion(courses)});
*/
class ChooseCourse extends StatefulWidget {
  const ChooseCourse({
    required this.courseId,
    required this.selectedCourses,
    required this.onSelectionChanged,
    super.key,
  });
  final String courseId;
  final Set<String> selectedCourses;
  final ValueChanged<bool> onSelectionChanged;

  @override
  State<ChooseCourse> createState() => _ChooseCourseState();
}

class _ChooseCourseState extends State<ChooseCourse> {
  bool get _isSelected => widget.selectedCourses.contains(widget.courseId);

  @override
  Widget build(BuildContext context) => Checkbox(
    value: _isSelected,
    onChanged: (value) {
      if (value != null) {
        widget.onSelectionChanged(value);
      }
    },
  );
}
