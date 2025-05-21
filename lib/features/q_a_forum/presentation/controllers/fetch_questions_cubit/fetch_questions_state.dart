part of 'fetch_questions_cubit.dart';

@immutable
sealed class FetchQuestionState {
  const FetchQuestionState();
}

final class _FetchQuestionInitial extends FetchQuestionState {
  const _FetchQuestionInitial();
}

final class QuestionLoading extends FetchQuestionState {
  const QuestionLoading();
}

final class QuestionSuccess extends FetchQuestionState {
  const QuestionSuccess(this.questions);
  final List<QuestionEntity> questions;
}

final class QuestionFailure extends FetchQuestionState {
  const QuestionFailure(this.message);
  final String message;
}
