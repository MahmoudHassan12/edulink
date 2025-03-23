import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

class DepartmentField extends StatelessWidget {
  const DepartmentField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) => CustomDropdownMenu(
    label: 'Department',
    controller: controller,
    dropdownMenuEntries:
        _departments
            .map((e) => DropdownMenuEntry<String>(value: e, label: e))
            .toList(),
  );
}

const List<String> _departments = [
  'All Departments',
  'Geophysics',
  'Microbiology',
  'Botany',
  'Physics',
  'Zoology',
  'Geology',
  'Entomology',
  'Chemistry',
  'Mathematics',
  'Biochemistry',
];
