part of 'fetch_answers_cubit.dart';

@immutable
sealed class FetchAnswerState {
  const FetchAnswerState();
}

final class FetchAnswerInitial extends FetchAnswerState {
  const FetchAnswerInitial();
}

final class AnswerLoading extends FetchAnswerState {
  const AnswerLoading();
}

final class AnswerSuccess extends FetchAnswerState {
  const AnswerSuccess(this.answer);
  final AnswerEntity? answer;
}

final class AnswerFailure extends FetchAnswerState {
  const AnswerFailure(this.message);
  final String message;
}
