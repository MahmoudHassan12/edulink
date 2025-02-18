import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {},
    radius: 50,
    borderRadius: BorderRadius.circular(50),
    child: const Padding(
      padding: EdgeInsets.all(4),
      child: CircleAvatar(
        radius: 24,
        backgroundImage: CachedNetworkImageProvider(
          'https://i.pravatar.cc/300',
        ),
      ),
    ),
  );
}
