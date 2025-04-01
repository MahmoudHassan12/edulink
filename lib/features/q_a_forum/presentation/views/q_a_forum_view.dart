import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_view_body.dart'
    show QAForumViewBody;
import 'package:edu_link/features/question_details/presentation/controllers/fetch_questions_cubit/fetch_questions_cubit.dart'
    show FetchQuestionsCubit;
import 'package:edu_link/features/question_details/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:flutter/material.dart'
    show BuildContext, Scaffold, StatelessWidget;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider;

class QAForumView extends StatelessWidget {
  const QAForumView({required this.course, super.key});
  final CourseEntity course;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    body: MultiBlocProvider(
      providers: [
        BlocProvider<QuestionManagerCubit>(
          create: (context) => QuestionManagerCubit(course.id!),
        ),
        BlocProvider(
          create: (context) => FetchQuestionsCubit(course.questions),
        ),
      ],
      child: QAForumViewBody(course: course, questions: course.questions ?? []),
    ),
  );
}
