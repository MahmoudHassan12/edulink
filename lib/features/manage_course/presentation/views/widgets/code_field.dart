import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CodeField extends StatelessWidget {
  const CodeField({this.controller, super.key});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    labelText: 'Course Code',
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    controller: controller,
  );
}
