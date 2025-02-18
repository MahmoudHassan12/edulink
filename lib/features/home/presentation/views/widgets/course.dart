import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage, CachedNetworkImageProvider;
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/views/widgets/text_icon.dart';
import 'package:flutter/material.dart';

class Course extends StatelessWidget {
  const Course({required this.course, super.key});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface.withAlpha(160);
    final professor = course.professor;
    final duration = course.duration;
    return Card.filled(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
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
                    child: CachedNetworkImage(
                      imageUrl: course.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      title: EText(
                        course.code!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: EText(course.title!),
                      trailing: IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_rounded),
                        selectedIcon: const Icon(Icons.favorite_rounded),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        right: 12,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextIcon(
                            icon: Icons.book_rounded,
                            title: '${course.lectures} Lectures',
                          ),
                        ),
                        Flexible(
                          child: TextIcon(
                            icon: Icons.watch_later_rounded,
                            title:
                                '${duration?.hours}:'
                                '${duration?.minutes}:${duration?.seconds}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            minVerticalPadding: 0,
            title: const EText('By'),
            subtitle: EText(professor!.name!),
            trailing: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(professor.imageUrl!),
            ),
          ),
        ],
      ),
    );
  }
}
