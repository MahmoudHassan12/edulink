import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        ElevatedButton,
        FilledButton,
        IconButton,
        MaterialTapTargetSize,
        MediaQuery,
        RoundedRectangleBorder,
        Size;

ButtonStyle styleCustomFilledButton(
  BuildContext context, {
  required bool hasMinimumSize,
}) => FilledButton.styleFrom(
  minimumSize:
      hasMinimumSize ? Size(MediaQuery.sizeOf(context).width, 56) : null,
  shape: const RoundedRectangleBorder(borderRadius: xsBorder),
);

ButtonStyle styleCustomIconButton() => IconButton.styleFrom(
  shape: const RoundedRectangleBorder(borderRadius: xxsBorder),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

ButtonStyle styleCustomElevatedButton(BuildContext context) =>
    ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: Size(MediaQuery.sizeOf(context).longestSide, 56),
      shape: const RoundedRectangleBorder(borderRadius: xxsBorder),
    );
