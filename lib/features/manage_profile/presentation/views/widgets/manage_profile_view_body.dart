import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/buttons/custom_elevated_button.dart';
import 'package:edu_link/core/widgets/custom_text_form_field.dart'
    show CustomTextFormField;
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_form.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/level_field.dart';
import 'package:edu_link/features/manage_profile/presentation/controllers/cubits/manage_profile_cubit/manage_profile_cubit.dart'
    show ManageProfileCubit;
import 'package:edu_link/features/manage_profile/presentation/views/widgets/department_field.dart'
    show DepartmentField;
import 'package:edu_link/features/manage_profile/presentation/views/widgets/email_field.dart'
    show EmailField;
import 'package:edu_link/features/manage_profile/presentation/views/widgets/name_field.dart'
    show NameField;
import 'package:edu_link/features/manage_profile/presentation/views/widgets/pick_image.dart'
    show PickImage;
import 'package:edu_link/features/manage_profile/presentation/views/widgets/program_field.dart'
    show ProgramField;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProfileViewBody extends StatefulWidget {
  const ManageProfileViewBody({super.key});
  @override
  State<ManageProfileViewBody> createState() => _ManageCourseViewBodyState();
}

class _ManageCourseViewBodyState extends State<ManageProfileViewBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _levelController;
  late final TextEditingController _ssnController;

  @override
  void initState() {
    final user = getUser();
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _phoneController = TextEditingController(text: user?.phone);
    _levelController = TextEditingController(text: user?.level);
    _ssnController = TextEditingController(text: user?.ssn);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _levelController.dispose();
    _ssnController.dispose();
    super.dispose();
  }

  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      PickImage(imageUrl: getUser()?.imageUrl),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const SizedBox(height: 16),
            NameField(controller: _nameController),
            EmailField(controller: _emailController),
            CustomTextFormField(
              labelText: 'Phone',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: _phoneController,
            ),
            const DepartmentField(),
            const ProgramField(),
            CustomTextFormField(
              labelText: 'SSN',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _ssnController,
            ),
            LevelField(controller: _levelController),
            CustomElevatedButton(
              onPressed: () async {
                final cubit =
                    context.read<ManageProfileCubit>()
                      ..setName(_nameController.text)
                      ..setEmail(_emailController.text)
                      ..setPhone(_phoneController.text)
                      ..setLevel(_levelController.text)
                      ..setSsn(_ssnController.text);
                if (cubit.user?.isValid() ?? false) {
                  await cubit.updateFireStore();
                  if (context.mounted) {
                    await homeNavigation(context);
                  }
                } else {
                  showSnackbar(
                    context,
                    'Please fill all the fields.',
                    flag: false,
                  );
                }
              },
              label: 'Done',
            ),
          ],
        ),
      ),
    ],
  );
}
