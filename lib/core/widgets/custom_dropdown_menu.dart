import 'dart:ui';

import 'package:edu_link/core/constants/borders.dart' show xsBorder;
import 'package:flutter/material.dart'
    show
        BuildContext,
        DropdownMenu,
        DropdownMenuEntry,
        EdgeInsets,
        InputDecorationTheme,
        MediaQuery,
        MenuStyle,
        OutlineInputBorder,
        RoundedSuperellipseBorder,
        SizedBox,
        StatelessWidget,
        Text,
        TextEditingController,
        TextInputType,
        ValueChanged,
        WidgetStatePropertyAll;

class CustomDropdownMenu<T> extends StatelessWidget {
  const CustomDropdownMenu({
    required this.label,
    required this.dropdownMenuEntries,
    this.controller,
    this.initialSelection,
    this.enabled = true,
    this.onSelected,
    super.key,
  });
  final TextEditingController? controller;
  final T? initialSelection;
  final String label;
  final List<DropdownMenuEntry<T?>> dropdownMenuEntries;
  final bool enabled;
  final ValueChanged<T?>? onSelected;
  @override
  SizedBox build(BuildContext context) {
    final Size sizeOf = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 80 + 4, // 4 is the padding of the text error.
      child: DropdownMenu<T?>(
        controller: controller,
        initialSelection: initialSelection,
        keyboardType: TextInputType.name,
        menuStyle: const MenuStyle(
          shape: WidgetStatePropertyAll(
            RoundedSuperellipseBorder(borderRadius: xsBorder),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
        ),
        enabled: enabled,
        enableFilter: true,
        width: sizeOf.width,
        menuHeight: sizeOf.height * 0.4,
        label: Text(label),
        onSelected: onSelected,
        dropdownMenuEntries: dropdownMenuEntries,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: xsBorder),
        ),
      ),
    );
  }
}
