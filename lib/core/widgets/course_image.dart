import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseImage extends StatelessWidget {
  const CourseImage({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) => Hero(
    tag: imageUrl,
    child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
  );
}
