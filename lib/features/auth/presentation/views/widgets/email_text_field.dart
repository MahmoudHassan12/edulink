import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        StatelessWidget,
        TextDirection,
        TextEditingController,
        TextInputAction,
        TextInputType,
        ValueChanged;
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    this.isLoading = false,
    this.emailController,
    this.textInputAction,
    this.onChanged,
    this.errorText,
  });
  final bool isLoading;
  final TextEditingController? emailController;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  @override
  CustomTextFormField build(BuildContext context) => CustomTextFormField(
    textDirection: TextDirection.ltr,
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    textInputAction: textInputAction,
    onChanged: onChanged,
    validator: _validateEmail,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp('[0-9@a-z.A-Z]')),
    ],
    enabled: isLoading ? false : null,
    labelText: 'Email',
    hintText: 'examble@email.com',
    prefixIcon: const Icon(Icons.email_rounded),
  );
}

String? _validateEmail(String? input) {
  if (input == null || input.isEmpty) {
    return 'This field is required.';
  } else if (!_firebaseEmailRegex.hasMatch(input)) {
    return 'The email address is badly formatted.';
  } else {
    return null;
  }
}

final _firebaseEmailRegex = RegExp(
  r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$',
  caseSensitive: false,
);

// RegExp _simpleEmailRegex = RegExp(
//   r'^[\w-\.]+@[\w-]+\.[\w-]{2,4}$',
// );

// RegExp _complexEmailRegex = RegExp(
//   r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
//   r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
//   r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
//   r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
//   r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
//   r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
//   r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
// );
