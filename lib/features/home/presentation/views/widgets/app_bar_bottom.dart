import 'package:flutter/material.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SearchBar(
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.search,
          color: IconTheme.of(context).color?.withAlpha(128),
        ),
      ),
      hintText: 'Search',
      trailing: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      constraints: const BoxConstraints(minHeight: 48),
      elevation: const WidgetStatePropertyAll(0),
    ),
  );
  @override
  Size get preferredSize => const Size.fromHeight(48);
}
