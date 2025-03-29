import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/question_details/presentation/views/widgets/question_details_view_body.dart'
    show QuestionDetailsViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget;

class QuestionDetailsView extends StatelessWidget {
  const QuestionDetailsView({required this.qa, super.key});
  final QuestionEntity qa;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const EText('Question Details')),
    body: QuestionDetailsViewBody(qa: qa),
  );
}
