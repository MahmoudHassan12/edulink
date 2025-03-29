import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_app_bar.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart';
import 'package:flutter/material.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({required this.course, super.key});
  final CourseEntity course;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      const QAForumAppBar(),
      SliverToBoxAdapter(
        child: ListTile(
          minTileHeight: 64,
          title: const EText('Questions'),
          trailing: CustomFilledButton(
            onPressed: () {},
            label: 'Ask a question',
            hasMinimumSize: false,
          ),
        ),
      ),
      SliverList.builder(
        itemCount: course.questions?.length,
        itemBuilder:
            (context, index) => QuestionCard(
              qa: course.questions?[index] ?? const QuestionEntity(),
            ),
      ),
    ],
  );
}
