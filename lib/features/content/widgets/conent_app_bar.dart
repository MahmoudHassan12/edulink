import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class ContentAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ContentAppbar({super.key});

  @override
  Widget build(BuildContext context) => AppBar(title: const EText('Content'));

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
