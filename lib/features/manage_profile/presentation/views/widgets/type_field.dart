import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

class TypeField extends StatelessWidget {
  const TypeField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomDropdownMenu(
    label: 'Type',
    controller: controller,
    dropdownMenuEntries: const [
      DropdownMenuEntry<String>(value: 'Regular', label: 'Regular'),
      DropdownMenuEntry<String>(value: 'Elective', label: 'Elective'),
    ],
  );
}
