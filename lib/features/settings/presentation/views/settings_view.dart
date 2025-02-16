import 'package:edu_link/features/settings/presentation/views/widgets/settings_view_body.dart'
    show SettingsViewBody;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Scaffold, StatelessWidget, Text;

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: const SettingsViewBody(),
  );
}
