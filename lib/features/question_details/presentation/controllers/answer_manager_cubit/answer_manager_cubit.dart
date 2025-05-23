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
  var _answer = const AnswerEntity();

  AnswerEntity _updateAnswer(AnswerEntity answer) => _answer = answer;

  void setQuestion(String question) {
    final AnswerEntity result = _answer.setAnswer(question);
    _updateAnswer(result);
    emit(_AnswerUpdated());
  }

  void setDate(DateTime date) {
    final AnswerEntity result = _answer.setDate(date);
    _updateAnswer(result);
    emit(_AnswerUpdated());
  }

  void setUser(UserEntity user) {
    final AnswerEntity result = _answer.setUser(user);
    _updateAnswer(result);
    emit(_AnswerUpdated());
  }

  Future<void> addAnswer() async {
    await const CoursesRepo().addAnswer(_courseId, _questionId, _answer);
    emit(const AnswerSuccess());
  }
}
