import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/features/chat/presentation/views/widgets/chat_header.dart'
    show ChatHeader;
import 'package:edu_link/features/chat/presentation/views/widgets/chat_view_body.dart'
    show ChatViewBody;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatView extends StatelessWidget {
  const ChatView({required this.receiver, super.key});
  final UserEntity receiver;
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: ChatHeader(user: receiver),
    body: Stack(
      fit: StackFit.expand,
      children: [const _ChatBackGround(), ChatViewBody(receiver: receiver)],
    ),
  );
}

class _ChatBackGround extends StatelessWidget {
  const _ChatBackGround();
  @override
  Widget build(BuildContext context) {
    final backgrounds = List<SvgPicture>.generate(4, (index) {
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final color = isDarkMode ? Colors.white : Colors.black;
      return SvgPicture.asset(
        'assets/images/chat_background.svg',
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(color.withAlpha(25), BlendMode.srcIn),
      );
    });
    return Column(
      children: backgrounds.map((e) => Flexible(child: e)).toList(),
    );
  }
}
