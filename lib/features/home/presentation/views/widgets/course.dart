import 'dart:async';

import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/navigations.dart'
    show courseDetailsNavigation;
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/widgets/course_image.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Course extends StatelessWidget {
  const Course({required this.course, super.key});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    final Color surface = Theme.of(context).colorScheme.surface.withAlpha(160);
    final UserEntity? professor = course.professor;
    final double width = MediaQuery.sizeOf(context).width - 88;
    return Card.filled(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedSuperellipseBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: InkWell(
        onTap: () => courseDetailsNavigation(context, extra: course),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            surface,
                            surface,
                            Colors.transparent,
                            surface,
                            surface,
                          ],
                        ),
                      ),
                      child: course.imageUrl == null
                          ? const Center(child: Icon(Icons.error))
                          : CourseImage(imageUrl: course.imageUrl!),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: OverflowBox(
                        alignment: Alignment.centerRight,
                        maxWidth: width,
                        fit: OverflowBoxFit.deferToChild,
                        child: ListTile(
                          title: EText(
                            course.code ?? 'No Code',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: EText(course.title ?? 'No Title'),
                          minVerticalPadding: 0,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: NumberOfStudents(courseId: course.id!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            OverflowBox(
              alignment: Alignment.centerRight,
              maxWidth: width,
              fit: OverflowBoxFit.deferToChild,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: const EText('By'),
                subtitle: EText('Dr. ${professor?.name}'),
                trailing: UserPhoto(user: professor ?? const UserEntity()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberOfStudents extends StatefulWidget {
  const NumberOfStudents({required this.courseId, super.key});
  final String courseId;
  @override
  State<NumberOfStudents> createState() => _NumberOfStudentsState();
}

class _NumberOfStudentsState extends State<NumberOfStudents> {
  int? _number = 0;
  Future<void> _getStudents() async {
    await const UserRepo()
        .streamUsersByCourse(widget.courseId)
        .map((List<UserEntity>? students) => _number = students?.length)
        .first;
    setState(() {});
  }

  @override
  void initState() {
    unawaited(_getStudents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Text.rich(
    overflow: TextOverflow.fade,
    softWrap: false,
    TextSpan(
      children: [
        const WidgetSpan(
          child: Icon(Icons.people_rounded),
          alignment: PlaceholderAlignment.middle,
        ),
        TextSpan(
          text: ' $_number Students',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
