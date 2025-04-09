import 'dart:async';

import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/services/chat_service.dart';
import 'package:edu_link/features/chat/widgets/chat_bubble.dart';
import 'package:edu_link/features/chat/widgets/chat_header.dart';
import 'package:edu_link/features/chat/widgets/send_message_input.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.sender, required this.receiver, super.key});
  final UserEntity sender;
  final UserEntity receiver;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatService _chatService;
  late List<Message> _messages;
  late TextEditingController _messageController;
  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    _messages = [];
    _messageController = TextEditingController();
    unawaited(_initializeChat());
  }

  Future<void> _initializeChat() =>
      _chatService.createChat(widget.sender.id!, widget.receiver.id!);

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    final sender = widget.sender;
    final receiver = widget.receiver;
    final message = Message(
      userId: sender.id!,
      text: _messageController.text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      messageId: '',
    );

    await _chatService.sendMessage(sender.id!, receiver.id!, message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final sender = widget.sender;
    final receiver = widget.receiver;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 165, 212, 236),
      appBar: ChatHeader(userName: receiver.name!, imgUrl: receiver.imageUrl!),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getChatMessages(sender.id!, receiver.id!),
              builder: (context, snapshot) {
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
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    var isSender = message.userId == sender.id;
                    return ChatBubble(
                      text: message.text,
                      userId: sender.id!,
                      senderId: message.userId,
                      isSender: isSender,
                      imgUrl: isSender ? sender.imageUrl : receiver.imageUrl,
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
