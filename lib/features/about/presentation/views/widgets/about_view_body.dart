import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart'
    show BuildContext, Center, StatelessWidget;

class AboutViewBody extends StatelessWidget {
  const AboutViewBody({super.key});
  @override
  Center build(BuildContext context) =>
      const Center(child: EText('About View'));
}
