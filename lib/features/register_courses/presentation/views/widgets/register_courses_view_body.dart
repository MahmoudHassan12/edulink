import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class RegisterCoursesViewBody extends StatelessWidget {
  const RegisterCoursesViewBody({super.key});
  @override
  Widget build(BuildContext context) => const CustomScrollView(
    slivers: [
      SliverAppBar(title: EText('Register Courses'), centerTitle: true),
    ],
  );
}
