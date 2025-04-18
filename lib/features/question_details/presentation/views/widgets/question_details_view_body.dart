import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart'
    show QuestionCard;
import 'package:edu_link/features/question_details/presentation/controllers/fetch_answers_cubit/fetch_answers_cubit.dart'
    show AnswerLoading, AnswerSuccess, FetchAnswerCubit, FetchAnswerState;
import 'package:edu_link/features/question_details/presentation/views/widgets/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;

class QuestionDetailsViewBody extends StatelessWidget {
  const QuestionDetailsViewBody({required this.qa, super.key});
  final QuestionEntity qa;
  Future<UserEntity?> get _fetchQuestion async =>
      const UserRepo().get(documentId: qa.user!.id!);
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: FutureBuilder(
          future: _fetchQuestion,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.hasData) {
              final user = snapshot.data;
              final updatedQA = qa.copyWith(user: user);
              return QuestionCard(qa: updatedQA);
            }
            return const Center(child: Text('No data found'));
          },
        ),
      ),
      SliverList.builder(
        itemCount: qa.answers?.length ?? 0,
        itemBuilder:
            (context, index) => BlocProvider<FetchAnswerCubit>(
              create: (context) => FetchAnswerCubit(qa.answers?[index]),
              child: BlocBuilder<FetchAnswerCubit, FetchAnswerState>(
                builder: (context, state) {
                  if (state is AnswerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AnswerSuccess) {
                    return AnswerCard(
                      answer: state.answer!,
                      hasDivider: index != (qa.answers?.length ?? 0) - 1,
                    );
                  }
                  return const Center(child: Text('Something went wrong'));
                },
              ),
            ),
      ),
    ],
  );
}
