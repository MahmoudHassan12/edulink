import 'package:edu_link/core/domain/entities/department_entity.dart';
import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:edu_link/features/manage_profile/presentation/controllers/cubits/manage_profile_cubit/manage_profile_cubit.dart'
    show ManageProfileCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentField extends StatelessWidget {
  const DepartmentField({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ManageProfileCubit>();
    final department = cubit.user?.department;
    return CustomDropdownMenu<DepartmentEntity>(
      controller: TextEditingController(text: department?.name),
      label: 'Department',
      initialSelection: department,
      dropdownMenuEntries:
          cubit.departments
              .map(
                (e) => DropdownMenuEntry<DepartmentEntity>(
                  value: e,
                  label: e.name ?? '',
                ),
              )
              .toList(),
      onSelected: (value) => cubit.setDepartment(value!),
    );
  }
}
