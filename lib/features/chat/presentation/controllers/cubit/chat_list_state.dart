part of 'chat_list_cubit.dart';

@immutable
sealed class ChatListState {}

final class ChatListInitial extends ChatListState {}

final class ChatListLoading extends ChatListState {}

final class ChatListSuccess extends ChatListState {
  ChatListSuccess({required this.chats});
  final List<ChatEntity> chats;
}

final class ChatListFailure extends ChatListState {
  ChatListFailure({required this.error});
  final String error;
}
