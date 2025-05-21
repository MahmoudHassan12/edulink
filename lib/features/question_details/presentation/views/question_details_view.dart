import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/controllers/fetch_questions_cubit/fetch_questions_cubit.dart';
import 'package:edu_link/features/question_details/presentation/controllers/answer_manager_cubit/answer_manager_cubit.dart';
import 'package:edu_link/features/question_details/presentation/views/answer_text_field.dart';
import 'package:edu_link/features/question_details/presentation/views/widgets/question_details_view_body.dart'
    show QuestionDetailsViewBody;
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Builder,
        Scaffold,
        StatelessWidget,
        TextEditingController,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocSelector, ReadContext;

class QuestionDetailsView extends StatelessWidget {
  const QuestionDetailsView({
    required this.qa,
    required this.qaContext,
    required this.courseId,
    super.key,
  });
  final QuestionEntity qa;
  final BuildContext qaContext;
  final String courseId;
  @override
  BlocProvider build(_) => BlocProvider<FetchQuestionsCubit>.value(
    value: BlocProvider.of<FetchQuestionsCubit>(qaContext),
    child: QuestionDetailsViewBlocSelector(question: qa, courseId: courseId),
  );
}

class QuestionDetailsViewBlocSelector extends StatelessWidget {
  const QuestionDetailsViewBlocSelector({
    required this.question,
    required this.courseId,
    super.key,
  });

  final QuestionEntity question;
  final String courseId;

  @override
  Widget build(_) =>
      BlocSelector<FetchQuestionsCubit, FetchQuestionsState, QuestionEntity?>(
        selector: (state) {
          if (state is QuestionSuccess) {
            return state.questions.firstWhere(
              (question) => question.id == this.question.id,
              orElse: () => question,
            );
          } else {
            return null;
          }
        },
        builder: (_, question) {
          return BlocProvider(
            create: (context) => AnswerManagerCubit(courseId, question.id!),
            child: Scaffold(
              appBar: AppBar(title: const EText('Question Details')),
              body: QuestionDetailsViewBody(question: question!),
              bottomSheet: Builder(
                builder: (context) {
                  final testController = TextEditingController();
                  Future<void> testOnSend() async {
                    final cubit = context.read<AnswerManagerCubit>()
                      ..setQuestion(testController.text)
                      ..setDate(DateTime.now())
                      ..setUser(getUser!);
                    return cubit.addAnswer();
                  }

                  return AnswerTextField(
                    labelText: 'Answer',
                    courseId: courseId,
                    questionId: question.id,
                    controller: testController,
                    onSend: () async => testOnSend(),
                  );
                },
              ),
            ),
          );
        },
      );
}
