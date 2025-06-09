import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.text,
    required this.user,
    required this.isSender,
    required this.isSameUser,
    super.key,
  });
  final String text;
  final UserEntity user;
  final bool isSender;
  final bool isSameUser;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: isSameUser ? 2 : 8),
    child:
        isSender
            ? _SenderBubble(user: user, text: text, isSameUser: isSameUser)
            : _ReceiverBubble(user: user, text: text, isSameUser: isSameUser),
  );
}

class _ReceiverBubble extends StatelessWidget {
  const _ReceiverBubble({
    required this.user,
    required this.text,
    required this.isSameUser,
  });
  final UserEntity user;
  final String text;
  final bool isSameUser;
  @override
  Widget build(BuildContext context) => Row(
    spacing: 8,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!isSameUser) UserPhoto(user: user) else const SizedBox(width: 40),
      _ReceiverMessage(text: text),
    ],
  );
}

class _ReceiverMessage extends StatelessWidget {
  const _ReceiverMessage({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => _Message(
    text: text,
    textColor: Colors.black87,
    backgroundColor: Colors.grey.shade200,
  );
}

class _SenderBubble extends StatelessWidget {
  const _SenderBubble({
    required this.user,
    required this.text,
    required this.isSameUser,
  });
  final UserEntity user;
  final String text;
  final bool isSameUser;
  @override
  Widget build(BuildContext context) => Row(
    spacing: 8,
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SenderMessage(text: text),
      if (!isSameUser) UserPhoto(user: user) else const SizedBox(width: 40),
    ],
  );
}

class _SenderMessage extends StatelessWidget {
  const _SenderMessage({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => _Message(
    text: text,
    textColor: Colors.white,
    backgroundColor: Colors.blue.shade600,
  );
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.textColor, this.backgroundColor});
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(context).width - 112,
    ),
    decoration: BoxDecoration(color: backgroundColor, borderRadius: xxsBorder),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: EText(
      text,
      style: TextStyle(color: textColor, fontSize: 16),
      softWrap: true,
    ),
  );
}
