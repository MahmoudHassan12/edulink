import 'package:edu_link/core/helpers/routes.dart' show routerConfig;
import 'package:edu_link/core/helpers/theme_config.dart' show ThemeConfig;
import 'package:edu_link/generated/l10n.dart' show AppLocalizationDelegate;
import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget;
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  MaterialApp build(BuildContext context) {
    final theme = ThemeConfig(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Edu Link',
      routerConfig: routerConfig,
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: theme.mode,
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const AppLocalizationDelegate().supportedLocales,
    );
  }
}
