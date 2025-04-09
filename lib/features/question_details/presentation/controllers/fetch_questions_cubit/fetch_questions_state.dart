part of 'fetch_questions_cubit.dart';

@immutable
sealed class FetchQuestionState {
  const FetchQuestionState();
}

final class FetchQuestionInitial extends FetchQuestionState {
  const FetchQuestionInitial();
}

final class QuestionLoading extends FetchQuestionState {
  const QuestionLoading();
}

final class QuestionSuccess extends FetchQuestionState {
  const QuestionSuccess(this.questions);
  final QuestionEntity? questions;
}

final class QuestionFailure extends FetchQuestionState {
  const QuestionFailure(this.message);
  final String message;
}
