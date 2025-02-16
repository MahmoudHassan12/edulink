import 'package:edu_link/features/about/presentation/views/widgets/about_view_body.dart'
    show AboutViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget, Text;

class AboutView extends StatelessWidget {
  const AboutView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('About')),
    body: const AboutViewBody(),
  );
}
