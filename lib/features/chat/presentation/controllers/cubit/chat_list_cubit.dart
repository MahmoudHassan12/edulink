import 'dart:async';

import 'package:edu_link/core/domain/entities/chat_entity.dart' show ChatEntity;
import 'package:edu_link/core/domain/entities/message_entity.dart'
    show MessageEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/entities_handlers.dart' show ListHandler;
import 'package:edu_link/core/helpers/flutter_local_notifications.dart'
    show LocalNotificationsHelper;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/services/chat_service.dart' show ChatService;
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' show HydratedCubit;

part 'chat_list_state.dart';

class ChatListCubit extends HydratedCubit<ChatListState> {
  ChatListCubit() : super(ChatListInitial()) {
    streamChats();
  }

  StreamSubscription<List<ChatEntity>>? _chatSubscription;

  StreamSubscription<List<ChatEntity>> streamChats() {
    emit(ChatListLoading());
    return _chatSubscription = const ChatService().streamChates().listen(
      (chats) async {
        if (chats.isEmpty) {
          emit(ChatListFailure(error: 'No chats available'));
        } else {
          final List<String?> recieversIds = chats
              .map(
                (chat) =>
                    chat.users?.firstWhere((user) => user.id != getUser?.id).id,
              )
              .toList();
          final List<UserEntity>? recievers = await const UserRepo()
              .getMultipleUsers(recieversIds.whereType<String>().toList());
          final List<ChatEntity> updatedChats =
              chats.map((chat) {
                final UserEntity? reciever = recievers?.firstWhere(
                  (user) =>
                      user.id ==
                      chat.users
                          ?.firstWhere((user) => user.id != getUser?.id)
                          .id,
                  orElse: UserEntity.new,
                );
                return chat.copyWith(users: [?getUser, ?reciever]);
              }).toList()..sort(
                (a, b) =>
                    b.messages?.last.date?.compareTo(
                      a.messages?.last.date ?? DateTime.now(),
                    ) ??
                    0,
              );
          final ChatEntity lastChat = updatedChats.first;
          final MessageEntity? lastMessage = lastChat.messages?.last;
          if (lastMessage?.user?.id != getUser?.id) {
            unawaited(
              LocalNotificationsHelper.show(
                id: lastChat.hashCode,
                title: lastChat.users?.last.name,
                body: lastChat.messages?.isNotEmpty ?? false
                    ? lastMessage?.text ?? 'You have a new message'
                    : 'You have a new message',
              ),
            );
          }
          emit(ChatListSuccess(chats: updatedChats));
        }
      },
      onError: (error) {
        emit(ChatListFailure(error: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    unawaited(_chatSubscription?.cancel());
    return super.close();
  }

  @override
  ChatListState? fromJson(Map<String, dynamic> json) {
    final List<ChatEntity>? chats = ListHandler.parseComplex<ChatEntity>(
      json['chats'],
      ChatEntity.fromMap,
    );
    return ChatListSuccess(chats: chats ?? []);
  }

  @override
  Map<String, dynamic>? toJson(ChatListState state) {
    if (state is ChatListSuccess) {
      return {'chats': state.chats.map((e) => e.toLocalMap()).toList()};
    }
    return null;
  }
}
