import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart'
    show QuestionEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_app_bar.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart';
import 'package:edu_link/features/question_details/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:edu_link/features/question_details/presentation/views/answer_text_field.dart'
    show AnswerTextField;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({required this.course, super.key});
  final CourseEntity course;
  Future<List<QuestionEntity>?> get _fetchQuestion async {
    final questions = course.questions;
    final usersId = questions?.map((q) => q.user?.id).toList();
    final users = await const UserRepo().getMultipleUsers(usersId);
    return questions?.map((q) {
      final selectedUser = users?.firstWhere((user) => user.id == q.user?.id);
      return q.copyWith(user: selectedUser);
    }).toList();
  }

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
                            onSend: () {
                              context.read<QuestionManagerCubit>()
                                ..setQuestion(controller.text)
                                ..setDate(DateTime.now())
                                ..setUser(getUser!)
                                ..setId()
                                ..addQuestion();
                              controller.clear();
                              popNavigation(context);
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
        FutureBuilder(
          future: _fetchQuestion,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return const SliverToBoxAdapter(
                child: Center(child: EText('Error loading questions')),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: EText('No questions available')),
              );
            }
            final questions = snapshot.data ?? [];
            return SliverList.builder(
              itemCount: questions.length,
              itemBuilder:
                  (_, index) =>
                      QuestionCard(qa: questions[index], courseId: course.id),
            );
          },
        ),
      ],
    );
  }
}
