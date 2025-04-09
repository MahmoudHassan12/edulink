import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_app_bar.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart';
import 'package:edu_link/features/question_details/presentation/controllers/fetch_questions_cubit/fetch_questions_cubit.dart'
    show FetchQuestionCubit, FetchQuestionState, QuestionSuccess;
import 'package:edu_link/features/question_details/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:edu_link/features/question_details/presentation/views/answer_text_field.dart'
    show AnswerTextField;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({required this.course, super.key});
  final CourseEntity course;
  @override
  CustomScrollView build(BuildContext context) {
    final questions = course.questions;
    final controller = TextEditingController();
    return CustomScrollView(
      slivers: [
        const QAForumAppBar(),
        SliverToBoxAdapter(
          child: ListTile(
            minTileHeight: 64,
            title: const EText('Questions'),
            trailing: CustomFilledButton(
              onPressed:
                  () async => showDialog(
                    context: context,
                    builder:
                        (_) => Dialog(
                          child: AnswerTextField(
                            controller: controller,
                            onSend: () {
                              context.read<QuestionManagerCubit>()
                                ..setQuestion(controller.text)
                                ..setDate(DateTime.now())
                                ..setUser(getUser!)
                                ..addQuestion().then((_) {
                                  controller.clear();
                                  if (context.mounted) popNavigation(context);
                                });
                            },
                          ),
                        ),
                  ),
              label: 'Ask a question',
              hasMinimumSize: false,
            ),
          ),
        ),
        if (questions?.isNotEmpty ?? false)
          SliverList.builder(
            itemCount: questions?.length,
            itemBuilder:
                (_, index) => BlocProvider<FetchQuestionCubit>(
                  create: (context) => FetchQuestionCubit(questions?[index]),
                  child: BlocBuilder<FetchQuestionCubit, FetchQuestionState>(
                    builder: (context, state) {
                      if (state is QuestionSuccess) {
                        return QuestionCard(qa: state.questions!);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
          )
        else
          const SliverToBoxAdapter(
            child: Center(child: Text('No questions yet')),
          ),
      ],
    );
  }
}
