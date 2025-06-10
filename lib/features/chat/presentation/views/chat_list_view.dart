import 'dart:async';
import 'package:edu_link/core/constants/borders.dart' show xsBorder;
import 'package:edu_link/core/domain/entities/chat_entity.dart' show ChatEntity;
import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/services/chat_service.dart' show ChatService;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart' show UserPhoto;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key, this.wantKeepAlive = true});
  final bool wantKeepAlive;
  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(body: ChatListViewBody());
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}

class ChatListViewBody extends StatelessWidget {
  const ChatListViewBody({super.key});
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        title: const EText('Chats'),
        floating: true,
        pinned: true,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      StreamBuilder<List<ChatEntity>>(
        stream: const ChatService().getChates(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return const SliverFillRemaining(
              child: Center(child: EText('Error loading chats')),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SliverFillRemaining(
              child: Center(child: EText('No chats available')),
            );
          }
          if (snapshot.hasData) {
            final List<ChatEntity>? chats =
                snapshot.data
                    ?.where((chat) => chat.messages?.isNotEmpty ?? false)
                    .toList()
                  ?..sort(
                    (a, b) =>
                        b.messages?.last.date?.compareTo(
                          a.messages?.last.date ?? DateTime.now(),
                        ) ??
                        0,
                  );
            if (chats?.isNotEmpty ?? false) {
              return ChatList(chats: chats ?? []);
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
    itemBuilder: (_, index) {
      final ChatEntity chat = chats[index];
      return ChatTile(chat: chat);
    },
  );
}

class ChatTile extends StatelessWidget {
  const ChatTile({required this.chat, super.key});
  final ChatEntity chat;
  Future<ChatEntity> get _init {
    final UserEntity? reciver = chat.users?.firstWhere(
      (user) => user.id != getUser?.id,
    );
    return const UserRepo()
        .getFromFireStore(documentId: reciver!.id!)
        .then((user) => chat.copyWith(users: [getUser!, user!]));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _init,
    builder: (_, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData) {
        return const Center(child: EText('No chats available'));
      }
      if (snapshot.hasError) {
        return const Center(child: EText('Error loading chat'));
      }
      final ChatEntity? chat = snapshot.data;
      final UserEntity? reciever = chat?.users?.last;
      final MessageEntity? lastMessage = chat?.messages?.last;
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
    },
  );
}
