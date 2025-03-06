import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    required this.imageUrl,
    this.radius,
    this.isHero = false,
    super.key,
  });
  final String? imageUrl;
  final double? radius;
  final bool isHero;
  @override
  Widget build(BuildContext context) {
    final url = imageUrl ?? 'https://avatar.iran.liara.run/public/32';
    final circleAvatar = CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(url),
      radius: radius,
    );
    return isHero ? Hero(tag: url, child: circleAvatar) : circleAvatar;
  }
}
