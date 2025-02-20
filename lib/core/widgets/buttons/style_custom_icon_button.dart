import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart'
    show ButtonStyle, IconButton, RoundedRectangleBorder;

ButtonStyle styleCustomIconButton() => IconButton.styleFrom(
  shape: const RoundedRectangleBorder(borderRadius: xxsBorder),
);
