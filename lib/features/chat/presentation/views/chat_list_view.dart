import 'package:edu_link/core/constants/borders.dart' show xsBorder;
import 'package:edu_link/core/domain/entities/chat_entity.dart' show ChatEntity;
import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart' show UserPhoto;
import 'package:edu_link/features/chat/presentation/controllers/cubit/chat_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:intl/intl.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key, this.wantKeepAlive = true});
  final bool wantKeepAlive;
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: ChatListViewBody());
}

class ChatListViewBody extends StatelessWidget {
  const ChatListViewBody({super.key});
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const SliverAppBar(title: EText('Chats')),
      BlocBuilder<ChatListCubit, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoading) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ChatListFailure) {
            return SliverFillRemaining(
              child: Center(child: EText(state.error)),
            );
          }
          if (state is ChatListSuccess) {
            final List<ChatEntity> chats = state.chats
                .where((chat) => chat.messages?.isNotEmpty ?? false)
                .toList();
            if (chats.isNotEmpty) {
              return ChatList(chats: chats);
            }
            return const SliverFillRemaining(
              child: Center(child: EText('No chats available')),
            );
          }
          return const SliverFillRemaining(
            child: Center(child: EText('No chats available')),
          );
        },
      ),
    ],
  );
}

class ChatList extends StatelessWidget {
  const ChatList({required this.chats, super.key});
  final List<ChatEntity> chats;
  @override
  Widget build(BuildContext context) => SliverList.builder(
    itemCount: chats.length,
    itemBuilder: (_, index) => ChatTile(chat: chats[index]),
  );
}

class ChatTile extends StatelessWidget {
  const ChatTile({required this.chat, super.key});
  final ChatEntity chat;
  @override
  Widget build(BuildContext context) {
    final UserEntity? reciever = chat.users?.last;
    final MessageEntity? lastMessage = chat.messages?.last;
    final String date = DateFormat(
      'MMMM dd, yyyy',
    ).format(lastMessage?.date ?? DateTime.now());
    final String time = DateFormat(
      'hh:mm a',
    ).format(lastMessage?.date ?? DateTime.now());
    return Card.filled(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: const RoundedSuperellipseBorder(borderRadius: xsBorder),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: ListTile(
        leading: UserPhoto(user: reciever!),
        title: EText(reciever.name ?? 'No Name'),
        subtitle: EText(lastMessage?.text ?? ''),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [EText(date), EText(time)],
        ),
        onTap: () => chatNavigation(context, extra: reciever),
      ),
    );
  }
}
