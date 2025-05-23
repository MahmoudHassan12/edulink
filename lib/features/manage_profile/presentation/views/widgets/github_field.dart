import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class GithubField extends StatelessWidget {
  const GithubField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    labelText: 'Github',
    hintText: 'Enter your GitHub account Link',
    keyboardType: TextInputType.webSearch,
    textInputAction: TextInputAction.next,
    controller: controller,
  );
}
