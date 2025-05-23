import 'dart:async';
import 'package:edu_link/core/domain/entities/chat_entity.dart';
import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/services/chat_service.dart';
import 'package:edu_link/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:edu_link/features/chat/presentation/views/widgets/send_message_input.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({required this.receiver, super.key});
  final UserEntity receiver;
  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  late final ChatService _chatService;
  late final TextEditingController _messageController;
  late final UserEntity? _sender;
  @override
  void initState() {
    super.initState();
    _chatService = const ChatService();
    _messageController = TextEditingController();
    _sender = getUser;
    unawaited(_initializeChat());
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() =>
      _chatService.init(_sender!.id!, widget.receiver.id!);

  Future<void> _sendMessage() async => _messageController.text.isEmpty
      ? null
      : _chatService
            .sendMessage(
              _sender!.id!,
              widget.receiver.id!,
              MessageEntity(
                user: _sender,
                text: _messageController.text,
                date: DateTime.now(),
              ),
            )
            .then((_) => _messageController.clear());

  @override
  Widget build(BuildContext context) {
    final UserEntity receiver = widget.receiver;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<ChatEntity>(
              stream: _chatService.getChat(_sender!.id!, receiver.id!),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('No messages yet.'));
                }
                final List<MessageEntity>? messages = snapshot
                    .data
                    ?.messages
                    ?.reversed
                    .toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: messages?.length,
                  itemBuilder: (_, index) {
                    final MessageEntity? message = messages?[index];
                    final isSender = message?.user?.id == _sender.id;
                    return ChatBubble(
                      text: message!.text!,
                      user: isSender ? _sender : receiver,
                      isSender: isSender,
                      isSameUser:
                          index < (messages?.length ?? 0) - 1 &&
                          messages?[index + 1].user?.id == message.user?.id,
                    );
                  },
                );
              },
            ),
          ),
          SendMessageInput(
            controller: _messageController,
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }
}
