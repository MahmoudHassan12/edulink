import 'dart:async' show StreamSubscription, unawaited;

import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'fetch_questions_state.dart';

class FetchQuestionsCubit extends Cubit<FetchQuestionState> {
  FetchQuestionsCubit(this.courseId) : super(const _FetchQuestionInitial()) {
    fetchQuestions();
  }
  final String courseId;

  late StreamSubscription<List<QuestionEntity>> _questionSubscription;

  StreamSubscription<List<QuestionEntity>> fetchQuestions() {
    emit(const QuestionLoading());
    try {
      return _questionSubscription = const CoursesRepo()
          .streamQuestions(courseId)
          .listen((questions) async {
            final usersIds = questions
                .map((question) => question.user!.id!)
                .toList();
            final users = await const UserRepo().getMultipleUsers(usersIds);
            final updatedQuestions = questions
                .map(
                  (question) => question.copyWith(
                    user: users?.firstWhere(
                      (user) => user.id == question.user?.id,
                      orElse: () => const UserEntity(),
                    ),
                  ),
                )
                .toList();
            emit(QuestionSuccess(updatedQuestions));
          });
    } catch (e) {
      emit(QuestionFailure(e.toString()));
      throw Exception(e);
    }
  }

  @override
  Future<void> close() {
    unawaited(_questionSubscription.cancel());
    return super.close();
  }
}
