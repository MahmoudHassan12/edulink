import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/about/presentation/views/widgets/about_view_body.dart'
    show AboutViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget;

class AboutView extends StatelessWidget {
  const AboutView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const EText('About')),
    body: const AboutViewBody(),
  );
}
