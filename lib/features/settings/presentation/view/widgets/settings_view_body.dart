import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/settings/presentation/view/widgets/theme/theme_manager.dart'
    show ThemeManager;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CustomScrollView,
        SliverAppBar,
        SliverChildListDelegate,
        SliverList,
        StatelessWidget,
        Widget;

final class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});
  @override
  CustomScrollView build(final BuildContext context) => const CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(title: EText('Settings')),
      SliverList(
        delegate: SliverChildListDelegate.fixed(<Widget>[ThemeManager()]),
      ),
    ],
  );
}
