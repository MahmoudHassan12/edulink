part of 'fetch_questions_cubit.dart';

@immutable
sealed class FetchQuestionsState {
  const FetchQuestionsState();
}

final class FetchQuestionsInitial extends FetchQuestionsState {
  const FetchQuestionsInitial();
}

final class QuestionsLoading extends FetchQuestionsState {
  const QuestionsLoading();
}

final class QuestionsSuccess extends FetchQuestionsState {
  const QuestionsSuccess(this.questions);
  final List<QuestionEntity>? questions;
}

final class QuestionsFailure extends FetchQuestionsState {
  const QuestionsFailure(this.message);
  final String message;
}
