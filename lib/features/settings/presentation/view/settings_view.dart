import 'package:edu_link/features/settings/presentation/view/widgets/settings_view_body.dart'
    show SettingsViewBody;
import 'package:flutter/material.dart' show Scaffold, StatelessWidget;

final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Scaffold build(_) => const Scaffold(body: SettingsViewBody());
}
