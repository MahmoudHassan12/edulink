import 'dart:async';
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
  late ChatService _chatService;
  late List<Message> _messages;
  late TextEditingController _messageController;
  final UserEntity? _sender = getUser;
  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    _messages = [];
    _messageController = TextEditingController();
    unawaited(_initializeChat());
  }

  Future<void> _initializeChat() =>
      _chatService.createChat(_sender!.id!, widget.receiver.id!);

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    final receiver = widget.receiver;
    final message = Message(
      userId: _sender!.id!,
      text: _messageController.text,
      date: DateTime.now(),
    );
    await _chatService.sendMessage(_sender.id!, receiver.id!, message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final receiver = widget.receiver;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getChatMessages(_sender!.id!, receiver.id!),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }
                _messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (_, index) {
                    final message = _messages[index];
                    final isSender = message.userId == _sender.id;
                    return ChatBubble(
                      text: message.text!,
                      user: isSender ? _sender : receiver,
                      isSender: isSender,
                      isSameUser:
                          index < _messages.length - 1 &&
                          _messages[index + 1].userId == message.userId,
                    );
                  },
                );
              },
            ),
          ),
          SendMessageInput(
            controller: _messageController,
            onSendMessage: () async => _sendMessage(),
          ),
        ],
      ),
    );
  }
}
