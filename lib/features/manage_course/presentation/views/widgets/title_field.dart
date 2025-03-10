import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    labelText: 'Course Title',
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    controller: controller,
  );
}
