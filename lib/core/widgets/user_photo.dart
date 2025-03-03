import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({required this.imageUrl, this.radius, super.key});
  final String imageUrl;
  final double? radius;
  @override
  Widget build(BuildContext context) => Hero(
    tag: imageUrl,
    child: CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      radius: radius,
    ),
  );
}
