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
    padding: const EdgeInsets.symmetric(vertical: 4),
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
      if (!isSameUser)
        UserPhoto(user: user, radius: 20)
      else
        const SizedBox(width: 40),
      _ReceiverMessage(text: text),
    ],
  );
}

class _ReceiverMessage extends StatelessWidget {
  const _ReceiverMessage({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(context).width - 112,
    ),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: xxsBorder,
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: EText(
      text,
      style: const TextStyle(color: Colors.black87, fontSize: 16),
      softWrap: true,
    ),
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
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(context).width - 112,
    ),
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: xxsBorder,
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: EText(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      softWrap: true,
    ),
  );
}
