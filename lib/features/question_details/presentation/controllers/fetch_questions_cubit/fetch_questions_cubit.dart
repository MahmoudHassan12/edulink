import 'dart:async';
import 'package:edu_link/core/domain/entities/question_entity.dart'
    show QuestionEntity;
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'fetch_questions_state.dart';

class FetchQuestionCubit extends Cubit<FetchQuestionState> {
  FetchQuestionCubit(this._question) : super(const FetchQuestionInitial()) {
    unawaited(_fetchQuestion());
  }
  final QuestionEntity? _question;
  Future<void> _fetchQuestion() async {
    emit(const QuestionLoading());
    final id = _question?.user?.id;
    final userStream = const UserRepo().getStream(documentId: id!);
    await for (final user in userStream) {
      emit(QuestionSuccess(_question!.copyWith(user: user)));
    }
  }
}
