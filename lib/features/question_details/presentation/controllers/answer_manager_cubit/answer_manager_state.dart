part of 'answer_manager_cubit.dart';

@immutable
sealed class AnswerManagerState {
  const AnswerManagerState();
}

final class _AnswerManagerInitial extends AnswerManagerState {
  const _AnswerManagerInitial();
}

final class AnswerLoading extends AnswerManagerState {
  const AnswerLoading();
}

final class AnswerSuccess extends AnswerManagerState {
  const AnswerSuccess();
}

final class AnswerFailure extends AnswerManagerState {
  const AnswerFailure(this.message);
  final String message;
}

final class _AnswerUpdated extends AnswerManagerState {}
