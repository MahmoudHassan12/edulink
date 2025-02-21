import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        StatelessWidget,
        Text,
        TextAlign,
        TextSpan,
        TextStyle,
        Theme,
        VoidCallback;

class HavingAccount extends StatelessWidget {
  const HavingAccount({
    super.key,
    this.isLoading = false,
    this.content,
    this.title,
    this.onTap,
  });
  final bool isLoading;
  final String? content;
  final String? title;
  final VoidCallback? onTap;
  @override
  Text build(BuildContext context) => Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      style: const TextStyle(fontSize: 16),
      children: [
        TextSpan(text: '$content '),
        TextSpan(
          text: title,
          style: TextStyle(
            color:
                isLoading ? Colors.grey : Theme.of(context).colorScheme.primary,
          ),
          recognizer:
              isLoading ? null : TapGestureRecognizer()
                ?..onTap = onTap,
        ),
      ],
    ),
  );
}
