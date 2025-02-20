import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        FilledButton,
        MediaQuery,
        RoundedRectangleBorder,
        Size;

ButtonStyle styleCustomFilledButton(BuildContext context) =>
    FilledButton.styleFrom(
      minimumSize: Size(MediaQuery.sizeOf(context).longestSide, 56),
      shape: const RoundedRectangleBorder(borderRadius: xsBorder),
    );
