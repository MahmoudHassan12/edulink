import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LinkedinField extends StatelessWidget {
  const LinkedinField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    labelText: 'LinkedIn',
    hintText: 'Enter your LinkedIn account Link',
    keyboardType: TextInputType.webSearch,
    textInputAction: TextInputAction.next,
    controller: controller,
  );
}
