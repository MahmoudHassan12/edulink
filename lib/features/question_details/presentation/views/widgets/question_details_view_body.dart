import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart'
    show QuestionCard;
import 'package:edu_link/features/question_details/presentation/views/widgets/answer_card.dart';
import 'package:flutter/material.dart';

class QuestionDetailsViewBody extends StatelessWidget {
  const QuestionDetailsViewBody({required this.qa, super.key});
  final QuestionEntity qa;
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(child: QuestionCard(qa: qa)),
      SliverList.builder(
        itemCount: qa.answers?.length ?? 0,
        itemBuilder:
            (context, index) => AnswerCard(
              answer: qa.answers![index],
              hasDivider: index != qa.answers!.length - 1,
            ),
      ),
    ],
  );
}
