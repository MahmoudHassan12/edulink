import 'dart:async';
import 'package:edu_link/core/domain/entities/question_entity.dart'
    show QuestionEntity;
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'fetch_questions_state.dart';

class FetchQuestionsCubit extends Cubit<FetchQuestionsState> {
  FetchQuestionsCubit(this._questions) : super(const FetchQuestionsInitial()) {
    unawaited(_fetchQuestions());
  }
  final List<QuestionEntity>? _questions;
  Future<void> _fetchQuestions() async {
    emit(const QuestionsLoading());
    final result = await Future.wait(
      _questions?.map((e) async {
            final usersIds = _questions.map((e) => e.user?.id).toList();
            final usersStream = const UserRepo().getMultibleUsersStream(
              usersIds,
            );
            await for (final users in usersStream) {
              return e.copyWith(
                user: users?.firstWhere((u) => u.id == e.user?.id),
              );
            }
            return e;
          }) ??
          <Future<QuestionEntity>>[],
    );
    emit(QuestionsSuccess(result));
  }
}
