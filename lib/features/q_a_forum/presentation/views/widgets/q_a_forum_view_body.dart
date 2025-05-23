import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/controllers/fetch_questions_cubit/fetch_questions_cubit.dart';
import 'package:edu_link/features/q_a_forum/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_app_bar.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart';
import 'package:edu_link/features/question_details/presentation/views/answer_text_field.dart'
    show AnswerTextField;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({required this.course, super.key});
  final CourseEntity course;
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
              onPressed: () => showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: AnswerTextField(
                    controller: controller,
                    onSend: () async {
                      final QuestionManagerCubit cubit =
                          context.read<QuestionManagerCubit>()
                            ..setQuestion(controller.text)
                            ..setDate(DateTime.now())
                            ..setUser(getUser!)
                            ..setId();

                      await cubit.addQuestion();
                      controller.clear();
                      if (context.mounted) {
                        popNavigation(context);
                      }
                    },
                    labelText: 'Ask',
                  ),
                ),
              ),
              label: 'Ask a question',
              hasMinimumSize: false,
            ),
          ),
        ),
        BlocBuilder<FetchQuestionsCubit, FetchQuestionsState>(
          builder: (_, state) {
            if (state is QuestionLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is QuestionSuccess) {
              final List<QuestionEntity> questions = state.questions;
              if (questions.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: EText('No questions available')),
                );
              }
              return SliverList.builder(
                itemCount: questions.length,
                itemBuilder: (_, index) =>
                    QuestionCard(qa: questions[index], courseId: course.id),
              );
            }
            if (state is QuestionFailure) {
              return const SliverToBoxAdapter(
                child: Center(child: EText('Error loading questions')),
              );
            }
            return const SliverToBoxAdapter();
          },
        ),
      ],
    );
  }
}
