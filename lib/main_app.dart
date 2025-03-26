import 'package:edu_link/core/helpers/routes.dart' show routerConfig;
import 'package:edu_link/core/helpers/theme_config.dart' show ThemeConfig;
import 'package:edu_link/generated/l10n.dart' show S;
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
  MaterialApp build(BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Edu Link',
    routerConfig: routerConfig,
    theme: const ThemeConfig().lightTheme,
    darkTheme: const ThemeConfig().darkTheme,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
  );
}
