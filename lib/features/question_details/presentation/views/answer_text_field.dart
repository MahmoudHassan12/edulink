import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AnswerTextField extends StatelessWidget {
  const AnswerTextField({this.onSend, super.key, this.controller});
  final VoidCallback? onSend;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => BottomSheet(
    onClosing: () {},
    enableDrag: false,
    elevation: 0,
    builder:
        (context) => Padding(
          padding: const EdgeInsets.all(8),
          child: CustomTextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            labelText: 'Answer',
            minLines: 1,
            maxLines: 4,
            hasHeight: false,
            suffixIcon: IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send_rounded),
            ),
          ),
        ),
  );
}
