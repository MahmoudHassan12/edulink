import 'package:edu_link/core/helpers/routes.dart' show routerConfig;
import 'package:edu_link/core/helpers/theme_config.dart' show ThemeConfig;
import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget;

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  MaterialApp build(BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Edu Link',
    routerConfig: routerConfig,
    theme: const ThemeConfig().lightTheme,
    darkTheme: const ThemeConfig().darkTheme,
  );
}
