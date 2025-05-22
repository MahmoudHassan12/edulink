import 'package:flutter/material.dart' show AutovalidateMode;

class AuthEntity {
  const AuthEntity({
    this.password1,
    this.password2,
    
    this.autovalidateMode,
  });

  final String? password1;
  final String? password2;
  
  final AutovalidateMode? autovalidateMode;

  AuthEntity copyWith({
    String? password1,
    String? password2,
    AutovalidateMode? autovalidateMode,
  }) => AuthEntity(
    password1: password1 ?? this.password1,
    password2: password2 ?? this.password2,
    autovalidateMode: autovalidateMode ?? this.autovalidateMode,
  );
  AuthEntity setPassword1(String password1) => copyWith(password1: password1);
  AuthEntity setPassword2(String password2) => copyWith(password2: password2);
  AuthEntity changeAutovalidateMode(AutovalidateMode mode) =>
      copyWith(autovalidateMode: mode);

  bool get isValid =>
      (password1?.isNotEmpty ?? false) &&
      (password2?.isNotEmpty ?? false) &&
      (password1 == password2);
}
