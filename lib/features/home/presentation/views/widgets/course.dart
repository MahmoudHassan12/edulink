import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';

class Course extends StatelessWidget {
  const Course({required this.course, super.key});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface.withAlpha(160);
    final professor = course.professor;
    return Card.filled(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Image(
                      image: NetworkImage(course.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      // position: DecorationPosition.foreground,
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
                      child: ListTile(
                        tileColor: Colors.amber,
                        splashColor: Colors.amberAccent,
                        title: EText(
                          course.code!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: EText(course.title!),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: OverflowBox(
                          maxHeight: double.infinity,
                          maxWidth: double.infinity,
                          alignment: Alignment.bottomRight,
                          child: Row(
                            spacing: 4,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.book_outlined),
                              EText(
                                '9 Lectures',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const EText('By'),
              subtitle: EText(professor!.name!),
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(professor.imageUrl!),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class EText extends StatelessWidget {
  const EText(this.data, {super.key, this.style});
  final String data;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) =>
      Text(data, overflow: TextOverflow.fade, softWrap: false, style: style);
}
