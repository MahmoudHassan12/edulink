import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  const NameField({this.controller, this.enabled = true, super.key});
  final TextEditingController? controller;
  final bool enabled;
  @override
  Widget build(BuildContext context) => CustomTextFormField(
    labelText: 'Name',
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    controller: controller,
    enabled: enabled,
  );
}
