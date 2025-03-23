import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

class LevelField extends StatelessWidget {
  const LevelField({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => CustomDropdownMenu(
    label: 'Level',
    controller: controller,
    dropdownMenuEntries: List<DropdownMenuEntry<int>>.generate(
      4,
      (index) => DropdownMenuEntry<int>(value: index++, label: '${index++}'),
    ),
  );
}
