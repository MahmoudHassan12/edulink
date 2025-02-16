import 'package:edu_link/core/helpers/theme_config.dart' show ThemeConfig;
import 'package:edu_link/features/home/presentation/views/home_view.dart'
    show HomeView;
import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget;

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  MaterialApp build(BuildContext context) => MaterialApp(
    home: const HomeView(),
    theme: const ThemeConfig().lightTheme,
    darkTheme: const ThemeConfig().darkTheme,
  );
}
