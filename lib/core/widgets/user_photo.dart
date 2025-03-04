import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    required this.imageUrl,
    this.radius,
    this.isHero = false,
    super.key,
  });
  final String imageUrl;
  final double? radius;
  final bool isHero;
  @override
  Widget build(BuildContext context) {
    final circleAvatar = CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      radius: radius,
    );
    return isHero ? Hero(tag: imageUrl, child: circleAvatar) : circleAvatar;
  }
}
