import 'dart:async';
import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'answer_manager_state.dart';

class AnswerManagerCubit extends Cubit<AnswerManagerState> {
  AnswerManagerCubit(this._courseId, this._questionId)
    : super(const _AnswerManagerInitial());
  final String _courseId;
  final String _questionId;
  AnswerEntity _answer = const AnswerEntity();

  AnswerEntity _updateQuestion(AnswerEntity question) => _answer = question;

  void setQuestion(String question) {
    final result = _answer.setAnswer(question);
    _updateQuestion(result);
    emit(_AnswerUpdated());
  }

  void setDate(DateTime date) {
    final result = _answer.setDate(date);
    _updateQuestion(result);
    emit(_AnswerUpdated());
  }

  void setUser(UserEntity user) {
    final result = _answer.setUser(user);
    _updateQuestion(result);
    emit(_AnswerUpdated());
  }

  Future<void> addQuestion() async {
    await const CoursesRepo().addAnswer(_courseId, _questionId, _answer);
    emit(const AnswerSuccess());
  }
}
