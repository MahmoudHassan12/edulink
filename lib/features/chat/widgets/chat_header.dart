import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChatHeader({required this.userName, required this.imgUrl, super.key});

  final String userName;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            backgroundImage:
                (imgUrl.isNotEmpty) ? CachedNetworkImageProvider(imgUrl) : null,
            child:
                imgUrl.isEmpty
                    ? Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: const TextStyle(color: Colors.black),
                    )
                    : null,
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: 10),
          Text(userName, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
