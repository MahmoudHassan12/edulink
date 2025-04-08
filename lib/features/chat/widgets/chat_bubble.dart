import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.text,
    required this.userId,
    required this.senderId,
    required this.isSender,
    super.key,
    this.imgUrl,
  });
  final String text;
  final String userId;
  final String senderId;
  final String? imgUrl;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isSender && imgUrl != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(imgUrl!),
                ),
              ),

            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isSender ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                text,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),

            if (isSender && imgUrl != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(imgUrl!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
