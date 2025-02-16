import 'package:edu_link/features/home/presentation/views/home_view.dart'
    show HomeView;
import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, Widget;

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomeView());
}
