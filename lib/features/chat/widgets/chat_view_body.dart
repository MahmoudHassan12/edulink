import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/services/chat_service.dart';
import 'package:edu_link/features/chat/widgets/chat_bubble.dart';
import 'package:edu_link/features/chat/widgets/chat_header.dart';
import 'package:edu_link/features/chat/widgets/send_message_input.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    required this.userId1,
    required this.userId2,
    required this.user1Name,
    required this.user2Name,
    required this.user1ImgUrl,
    required this.user2ImgUrl,
    required this.currentUserId,
    super.key,
  });
  final String currentUserId;
  final String userId1;
  final String userId2;
  final String user1Name;
  final String user2Name;
  final String user1ImgUrl;
  final String user2ImgUrl;

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
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

    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _chatService.createChat(widget.userId1, widget.userId2);
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = Message(
      userId: widget.userId1,
      text: _messageController.text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      messageId: '',
    );

    await _chatService.sendMessage(widget.userId1, widget.userId2, message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUserSender = widget.currentUserId == widget.userId1;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 165, 212, 236),
      appBar: ChatHeader(
        userName: isCurrentUserSender ? widget.user2Name : widget.user1Name,
        imgUrl: isCurrentUserSender ? widget.user2ImgUrl : widget.user1ImgUrl,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getChatMessages(
                widget.userId1,
                widget.userId2,
              ),
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
                    var isSender = message.userId == widget.userId1;

                    return ChatBubble(
                      text: message.text,
                      userId: widget.userId1,
                      senderId: message.userId,
                      isSender: isSender,
                      imgUrl:
                          isSender ? widget.user1ImgUrl : widget.user2ImgUrl,
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
