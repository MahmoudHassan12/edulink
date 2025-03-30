import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_app_bar.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart';
import 'package:edu_link/features/question_details/presentation/controllers/fetch_questions_cubit/fetch_questions_cubit.dart'
    show FetchQuestionsCubit, FetchQuestionsState, QuestionsSuccess;
import 'package:edu_link/features/question_details/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:edu_link/features/question_details/presentation/views/answer_text_field.dart'
    show AnswerTextField;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({
    required this.course,
    required this.questions,
    super.key,
  });
  final CourseEntity course;
  final List<QuestionEntity> questions;
  @override
  CustomScrollView build(BuildContext context) {
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
                            onSend:
                                () =>
                                    context.read<QuestionManagerCubit>()
                                      ..setQuestion(controller.text)
                                      ..setDate(DateTime.now())
                                      ..setUser(getUser!)
                                      ..addQuestion(),
                          ),
                        ),
                  ),
              label: 'Ask a question',
              hasMinimumSize: false,
            ),
          ),
        ),
        BlocBuilder<FetchQuestionsCubit, FetchQuestionsState>(
          builder: (context, state) {
            if (state is QuestionsSuccess) {
              final questions = state.questions;
              return (questions?.isNotEmpty ?? false)
                  ? SliverList.builder(
                    itemCount: questions?.length,
                    itemBuilder:
                        (context, index) => QuestionCard(qa: questions![index]),
                  )
                  : const SliverToBoxAdapter(
                    child: Center(child: Text('No questions yet')),
                  );
            }
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ],
    );
  }
}
