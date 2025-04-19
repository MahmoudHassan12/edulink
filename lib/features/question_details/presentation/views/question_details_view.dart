import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
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
        TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocSelector, ReadContext;

class QuestionDetailsView extends StatelessWidget {
  const QuestionDetailsView({
    required this.qa,
    required this.qDContext,
    required this.courseId,
    super.key,
  });
  final QuestionEntity qa;
  final BuildContext qDContext;
  final String courseId;
  @override
  BlocSelector build(BuildContext context) =>
      BlocSelector<HomeCubit, HomeState, QuestionEntity>(
        selector: (state) {
          if (state is HomeSuccess) {
            final d = state.courses?.firstWhere((element) {
              final q = element.questions?.firstWhere(
                (element) => element.id == qa.id,
                orElse: () => qa,
              );
              if (q?.id == qa.id) {
                return true;
              } else {
                return false;
              }
            });
            return d?.questions?.firstWhere(
                  (element) => element.id == qa.id,
                  orElse: () => qa,
                ) ??
                qa;
          } else {
            return qa;
          }
        },
        builder: (context, state) {
          return BlocProvider<AnswerManagerCubit>(
            create: (context) => AnswerManagerCubit(courseId, state.id!),
            child: Scaffold(
              appBar: AppBar(title: const EText('Question Details')),
              body: QuestionDetailsViewBody(qa: state),
              bottomSheet: Builder(
                builder: (context) {
                  final testController = TextEditingController();
                  Future<void> testOnSend() async {
                    final cubit =
                        context.read<AnswerManagerCubit>()
                          ..setQuestion(testController.text)
                          ..setDate(DateTime.now())
                          ..setUser(getUser!);
                    return cubit.addQuestion();
                  }

                  return AnswerTextField(
                    labelText: 'Answer',
                    courseId: courseId,
                    questionId: state.id,
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
