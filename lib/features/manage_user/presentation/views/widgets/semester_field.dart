import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

class SemesterField extends StatelessWidget {
  const SemesterField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomDropdownMenu(
    controller: controller,
    label: 'Semester',
    dropdownMenuEntries: const [
      DropdownMenuEntry<String>(value: 'Fall', label: 'Fall'),
      DropdownMenuEntry<String>(value: 'Spring', label: 'Spring'),
      DropdownMenuEntry<String>(value: 'Summer', label: 'Summer'),
    ],
  );
}
