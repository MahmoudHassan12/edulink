import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        FormFieldValidator,
        InputDecoration,
        OutlineInputBorder,
        SizedBox,
        StatelessWidget,
        TextAlign,
        TextDirection,
        TextEditingController,
        TextFormField,
        TextInputAction,
        TextInputType,
        TextOverflow,
        TextStyle,
        ValueChanged,
        Widget;
import 'package:flutter/services.dart' show TextInputFormatter;

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.textDirection,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.labelText,
    this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.suffixText,
    this.suffixIcon,
    this.isDecorationCollapsed = false,
  });
  final TextDirection? textDirection;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final String? suffixText;
  final Widget? suffixIcon;
  final bool isDecorationCollapsed;
  @override
  SizedBox build(BuildContext context) => SizedBox(
    height:
        isDecorationCollapsed
            ? null
            : 80 + 4, // 4 is the padding of the text error.
    child: TextFormField(
      textDirection: textDirection,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style:
          style?.copyWith(overflow: TextOverflow.fade) ??
          const TextStyle(overflow: TextOverflow.fade),
      textAlign: textAlign,
      obscuringCharacter: '৹', //⋇⊛৹⁕
      obscureText: obscureText,
      autocorrect: false,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      decoration:
          isDecorationCollapsed
              ? InputDecoration.collapsed(
                hintText: hintText,
                hintTextDirection: textDirection,
              )
              : InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(overflow: TextOverflow.fade),
                hintText: hintText,
                hintTextDirection: textDirection,
                prefixText: prefixText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: const OutlineInputBorder(borderRadius: xsBorder),
              ),
    ),
  );
}
