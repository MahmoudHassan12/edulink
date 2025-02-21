import 'package:edu_link/core/helpers/navigations.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key, this.isLoading = false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 80 + 4,
    child: Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStatePropertyAll(Size.zero),
          visualDensity: VisualDensity.compact,
        ),
        onPressed:
            isLoading ? null : () async => resetPasswordNavigation(context),
        child: const Text('Forgot Password?', style: TextStyle(fontSize: 14)),
      ),
    ),
  );
}
