import 'dart:async';
import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'fetch_answers_state.dart';

class FetchAnswerCubit extends Cubit<FetchAnswerState> {
  FetchAnswerCubit(this._answer) : super(const FetchAnswerInitial()) {
    unawaited(_fetchAnswer());
  }
  final AnswerEntity? _answer;
  Future<void> _fetchAnswer() async {
    emit(const AnswerLoading());
    final id = _answer?.user?.id;
    final userStream = const UserRepo().getStream(documentId: id!);
    await for (final user in userStream) {
      emit(AnswerSuccess(_answer!.copyWith(user: user)));
    }
  }
}
