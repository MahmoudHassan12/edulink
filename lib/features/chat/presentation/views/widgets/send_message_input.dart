import 'package:edu_link/core/widgets/buttons/custom_icon_button_filled_tonal.dart';
import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SendMessageInput extends StatelessWidget {
  const SendMessageInput({
    required this.controller,
    required this.onSendMessage,
    super.key,
  });
  final TextEditingController controller;
  final VoidCallback onSendMessage;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
    child: Row(
      spacing: 12,
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 4,
            minLines: 1,
            hintText: 'Type a message...',
            hasHeight: false,
          ),
        ),
        CustomIconButtonFilledTonal(
          onPressed: () => onSendMessage(),
          icon: Icons.send_rounded,
          iconSize: 32,
        ),
      ],
    ),
  );
}
