import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    labelText: 'Email',
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    controller: controller,
  );
}
