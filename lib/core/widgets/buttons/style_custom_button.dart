import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        ElevatedButton,
        FilledButton,
        IconButton,
        MediaQuery,
        RoundedRectangleBorder,
        Size;

ButtonStyle styleCustomFilledButton(BuildContext context) =>
    FilledButton.styleFrom(
      minimumSize: Size(MediaQuery.sizeOf(context).longestSide, 56),
      shape: const RoundedRectangleBorder(borderRadius: xsBorder),
    );

ButtonStyle styleCustomIconButton() => IconButton.styleFrom(
  shape: const RoundedRectangleBorder(borderRadius: xxsBorder),
);

ButtonStyle styleCustomElevatedButton(BuildContext context) =>
    ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: Size(MediaQuery.sizeOf(context).longestSide, 56),
      shape: const RoundedRectangleBorder(borderRadius: xxsBorder),
    );
