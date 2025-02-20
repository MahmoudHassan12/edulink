import 'package:edu_link/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        FocusNode,
        Icon,
        IconButton,
        Icons,
        StatelessWidget,
        TextDirection,
        TextEditingController,
        TextInputAction,
        TextInputType,
        ValueChanged;

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.isLoading = false,
    this.isVisible = false,
    this.setVisible,
    this.onChanged,
    this.passwordController,
    this.textInputAction,
    this.labelText,
  });
  final bool isLoading;
  final bool isVisible;
  final ValueChanged<bool>? setVisible;
  final ValueChanged<String>? onChanged;
  final TextEditingController? passwordController;
  final TextInputAction? textInputAction;
  final String? labelText;
  @override
  CustomTextFormField build(BuildContext context) => CustomTextFormField(
    textDirection: TextDirection.ltr,
    controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    textInputAction: textInputAction,
    obscureText: !isVisible,
    onChanged: onChanged,
    validator: _validatePassword,
    enabled: isLoading ? false : null,
    labelText: labelText,
    hintText: r'P@s$w0rd',
    prefixIcon: const Icon(Icons.password_rounded),
    suffixIcon: IconButton(
      focusNode: FocusNode(skipTraversal: true),
      onPressed: () {
        isVisible ? setVisible?.call(false) : setVisible?.call(true);
      },
      icon: const Icon(Icons.visibility_rounded),
      selectedIcon: const Icon(Icons.visibility_off_rounded),
      isSelected: isVisible,
    ),
  );
}

String? _validatePassword(String? input) {
  if (input?.isEmpty ?? true) {
    return 'This field is required.';
  } else if ((input?.length ?? 0) < 6) {
    return 'Password must be at least 6 characters long.';
  } else {
    return null;
  }
}
