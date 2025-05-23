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
import 'package:edu_link/features/manage_profile/presentation/views/widgets/github_field.dart';
import 'package:edu_link/features/manage_profile/presentation/views/widgets/linkedin_field.dart';
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
  late final TextEditingController _gitHubController;
  late final TextEditingController _linkedInController;

  @override
  void initState() {
    final user = getUser;
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _phoneController = TextEditingController(text: user?.phone);
    _levelController = TextEditingController(text: user?.level);
    _ssnController = TextEditingController(text: user?.ssn);
    _gitHubController = TextEditingController(text: user?.gitHubLink);
    _linkedInController = TextEditingController(text: user?.linkedInLink);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _levelController.dispose();
    _ssnController.dispose();
    _gitHubController.dispose();
    _linkedInController.dispose();

    super.dispose();
  }

  bool _isValidLinkedIn(String? url) {
    if (url == null || url.trim().isEmpty) return true;
    const pattern = r'^(https?:\/\/)?(www\.)?linkedin\.com\/.*$';
    return RegExp(pattern).hasMatch(url.trim());
  }

  bool _isValidGitHub(String? url) {
    if (url == null || url.trim().isEmpty) return true;
    const pattern = r'^(https?:\/\/)?(www\.)?github\.com\/[A-Za-z0-9_-]+\/?$';
    return RegExp(pattern).hasMatch(url.trim());
  }

  bool _isValidEmail(String? email) {
    if (email == null || email.trim().isEmpty) return false;
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(pattern).hasMatch(email.trim());
  }

  bool _isValidPhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) return false;
    const pattern = r'^\+?\d{10,15}$'; 
    return RegExp(pattern).hasMatch(phone.trim());
  }

  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      PickImage(imageUrl: getUser?.imageUrl),
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
            GithubField(controller: _gitHubController),
            LinkedinField(controller: _linkedInController),
            CustomElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final email = _emailController.text.trim();
                final phone = _phoneController.text.trim();
                final level = _levelController.text.trim();
                final ssn = _ssnController.text.trim();
                final github = _gitHubController.text.trim();
                final linkedin = _linkedInController.text.trim();

                if (!_isValidEmail(email)) {
                  showSnackbar(
                    context,
                    'Please enter a valid email address.',
                    flag: false,
                  );
                  return;
                }

                if (!_isValidPhone(phone)) {
                  showSnackbar(
                    context,
                    'Please enter a valid phone number.',
                    flag: false,
                  );
                  return;
                }

                if (!_isValidGitHub(github)) {
                  showSnackbar(context, 'Invalid GitHub link.', flag: false);
                  return;
                }

                if (!_isValidLinkedIn(linkedin)) {
                  showSnackbar(context, 'Invalid LinkedIn link.', flag: false);
                  return;
                }

                final cubit = context.read<ManageProfileCubit>()
                  ..setName(name)
                  ..setEmail(email)
                  ..setPhone(phone)
                  ..setLevel(level)
                  ..setSsn(ssn)
                  ..setGitHub(github)
                  ..setLinkedIn(linkedin);

                if (cubit.user?.isValid ?? false) {
                  await cubit.update();
                  if (context.mounted) await homeNavigation(context);
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
