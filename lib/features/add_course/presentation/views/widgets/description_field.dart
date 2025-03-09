import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    keyboardType: TextInputType.multiline,
    textInputAction: TextInputAction.newline,
    labelText: 'Course Description',
    maxLines: 20,
    minLines: 1,
    controller: controller,
  );
}
