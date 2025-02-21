import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/password_text_field.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Form,
        FormState,
        GlobalKey,
        StatelessWidget,
        TextInputAction;

class RegisterForm extends StatelessWidget {
  const RegisterForm({this.isLoading = false, super.key});
  final bool isLoading;
  @override
  Form build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailTextField(
            isLoading: isLoading,

            textInputAction: TextInputAction.next,
            onChanged: (value) {},
          ),
          PasswordTextField(
            isLoading: isLoading,
            setVisible: (isVisible) {},

            textInputAction: TextInputAction.next,
            labelText: 'Password',
            onChanged: (value) {},
          ),
          PasswordTextField(
            isLoading: isLoading,
            setVisible: (isVisible) {},

            textInputAction: TextInputAction.go,
            labelText: 'Confirm Password',
          ),
          CustomFilledButton(
            label: 'Register',
            onPressed:
                isLoading
                    ? null
                    : () async {
                      if (formKey.currentState?.validate() ?? false) {}
                    },
          ),
        ],
      ),
    );
  }
}
