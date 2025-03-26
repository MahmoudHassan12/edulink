import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_view_body.dart'
    show QAForumViewBody;
import 'package:flutter/material.dart'
    show BuildContext, Scaffold, StatelessWidget;

class QAForumView extends StatelessWidget {
  const QAForumView({super.key});
  @override
  Scaffold build(BuildContext context) =>
      const Scaffold(body: QAForumViewBody());
}
