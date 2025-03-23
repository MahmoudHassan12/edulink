import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart'
    show BuildContext, Center, StatelessWidget;

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});
  @override
  Center build(BuildContext context) =>
      const Center(child: EText('Settings View'));
}
