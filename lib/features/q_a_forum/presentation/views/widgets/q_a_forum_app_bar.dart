import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class QAForumAppBar extends StatelessWidget {
  const QAForumAppBar({super.key});
  @override
  Widget build(BuildContext context) => SliverAppBar(
    title: const EText('Q&A Forum'),
    expandedHeight: MediaQuery.sizeOf(context).height * 0.3,
    flexibleSpace: FlexibleSpaceBar(
      background: Image.asset(
        'assets/images/qa_forum.png',
        fit: BoxFit.cover,
        color: Colors.black.withAlpha(100),
        colorBlendMode: BlendMode.darken,
      ),
    ),
    shape: const RoundedSuperellipseBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
  );
}
