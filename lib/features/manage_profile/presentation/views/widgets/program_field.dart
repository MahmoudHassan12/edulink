import 'package:edu_link/core/domain/entities/program_entity.dart';
import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:edu_link/features/manage_profile/presentation/controllers/cubits/manage_profile_cubit/manage_profile_cubit.dart'
    show ManageProfileCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramField extends StatelessWidget {
  const ProgramField({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ManageProfileCubit>();
    final department = cubit.user?.department;
    final program = cubit.user?.program;
    return CustomDropdownMenu<ProgramEntity>(
      label: 'Program',
      controller: TextEditingController(text: program?.name),
      initialSelection: program,
      dropdownMenuEntries:
          cubit.programs
              .where((e) => e.departmentId == department?.id)
              .map(
                (e) => DropdownMenuEntry<ProgramEntity>(
                  value: e,
                  label: e.name ?? '',
                ),
              )
              .toList(),
      onSelected: (value) => cubit.setProgram(value!),
      enabled: department?.isValid ?? false,
    );
  }
}
