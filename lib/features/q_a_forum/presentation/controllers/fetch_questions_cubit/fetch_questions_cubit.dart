import 'dart:async' show StreamSubscription, unawaited;

import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'fetch_questions_state.dart';

class FetchQuestionsCubit extends Cubit<FetchQuestionsState> {
  FetchQuestionsCubit(this._courseId) : super(const _FetchQuestionInitial()) {
    _fetchQuestions();
  }
  final String _courseId;

  late StreamSubscription<List<QuestionEntity>> _questionSubscription;

  StreamSubscription<List<QuestionEntity>> _fetchQuestions() {
    emit(const QuestionLoading());
    return _questionSubscription = const CoursesRepo()
        .streamQuestions(_courseId)
        .listen((questions) async {
          if (questions.isEmpty) {
            return emit(const QuestionSuccess([]));
          }
          final List<String> usersIds = questions
              .map((question) => question.user!.id!)
              .toList();
          final List<UserEntity>? questionUsers = await const UserRepo()
              .getMultipleUsers(usersIds);
          final List<QuestionEntity> updatedQuestions =
              await Future.wait<QuestionEntity>(
                questions.map((question) async {
                  final List<AnswerEntity>? answers = question.answers;
                  final List<String>? usersIds = answers
                      ?.map((answer) => answer.user!.id!)
                      .toList();
                  final List<UserEntity>? users = usersIds?.isNotEmpty ?? false
                      ? await const UserRepo().getMultipleUsers(usersIds!)
                      : null;
                  return question.copyWith(
                    user: questionUsers?.firstWhere(
                      (user) => user.id == question.user?.id,
                    ),
                    answers: answers
                        ?.map(
                          (answer) => answer.copyWith(
                            user: users?.firstWhere(
                              (user) => user.id == answer.user?.id,
                            ),
                          ),
                        )
                        .toList()
                        .reversed
                        .toList(),
                  );
                }).toList(),
              );
          return emit(QuestionSuccess(updatedQuestions));
        }, onError: (error) => emit(QuestionFailure(error.toString())));
  }

  @override
  Future<void> close() {
    unawaited(_questionSubscription.cancel());
    return super.close();
  }
}
