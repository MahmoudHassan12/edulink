part of 'fetch_questions_cubit.dart';

@immutable
sealed class FetchQuestionsState {
  const FetchQuestionsState();
}

final class _FetchQuestionInitial extends FetchQuestionsState {
  const _FetchQuestionInitial();
}

final class QuestionLoading extends FetchQuestionsState {
  const QuestionLoading();
}

final class QuestionSuccess extends FetchQuestionsState {
  const QuestionSuccess(this.questions);
  final List<QuestionEntity> questions;
}

final class QuestionFailure extends FetchQuestionsState {
  const QuestionFailure(this.message);
  final String message;
}
