part of 'question_manager_cubit.dart';

@immutable
sealed class QuestionManagerState {
  const QuestionManagerState();
}

final class _QuestionManagerInitial extends QuestionManagerState {
  const _QuestionManagerInitial();
}

final class QuestionLoading extends QuestionManagerState {
  const QuestionLoading();
}

final class QuestionSuccess extends QuestionManagerState {
  const QuestionSuccess();
}

final class QuestionError extends QuestionManagerState {
  const QuestionError(this.message);
  final String message;
}

final class _QuestionUpdated extends QuestionManagerState {}
