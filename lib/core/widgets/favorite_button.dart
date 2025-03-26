import 'package:edu_link/core/helpers/navigations.dart' show qaForumNavigation;
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) => IconButton.outlined(
    onPressed: () async {
      await qaForumNavigation(context);
      setState(() => isFavorite = !isFavorite);
    },
    icon: const Icon(Icons.favorite_border_rounded),
    selectedIcon: const Icon(Icons.favorite_rounded),
    isSelected: isFavorite,
    color: Theme.of(context).colorScheme.primaryContainer,
    style: IconButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
