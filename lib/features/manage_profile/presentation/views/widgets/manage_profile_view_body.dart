import 'package:edu_link/core/domain/entities/available_time_entity.dart';
import 'package:edu_link/core/domain/entities/location_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/buttons/custom_elevated_button.dart';
import 'package:edu_link/core/widgets/buttons/custom_outlined_button.dart';
import 'package:edu_link/core/widgets/custom_dropdown_menu.dart';
import 'package:edu_link/core/widgets/custom_text_form_field.dart'
    show CustomTextFormField;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_form.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/level_field.dart';
import 'package:edu_link/features/manage_profile/presentation/controllers/cubits/manage_profile_cubit/manage_profile_cubit.dart'
    show ManageProfileCubit, ManageProfileState;
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
  late final TextEditingController _buildingController;
  late final TextEditingController _floorController;
  late final TextEditingController _roomController;

  @override
  void initState() {
    final UserEntity? user = getUser;
    final LocationEntity? location = user?.office?.location;
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _phoneController = TextEditingController(text: user?.phone);
    _levelController = TextEditingController(text: user?.level);
    _ssnController = TextEditingController(text: user?.ssn);
    _gitHubController = TextEditingController(text: user?.gitHubLink);
    _linkedInController = TextEditingController(text: user?.linkedInLink);
    _buildingController = TextEditingController(text: location?.building);
    _floorController = TextEditingController(text: location?.floor);
    _roomController = TextEditingController(text: location?.room);
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
    if (url == null || url.trim().isEmpty) {
      return true;
    }
    const pattern = r'^(https?:\/\/)?(www\.)?linkedin\.com\/.*$';
    return RegExp(pattern).hasMatch(url.trim());
  }

  bool _isValidGitHub(String? url) {
    if (url == null || url.trim().isEmpty) {
      return true;
    }
    const pattern = r'^(https?:\/\/)?(www\.)?github\.com\/[A-Za-z0-9_-]+\/?$';
    return RegExp(pattern).hasMatch(url.trim());
  }

  bool _isValidEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return false;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(pattern).hasMatch(email.trim());
  }

  bool _isValidPhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return false;
    }
    const pattern = r'^\+?\d{10,15}$';
    return RegExp(pattern).hasMatch(phone.trim());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ManageProfileCubit, ManageProfileState>(
        builder: (context, state) {
          final bool isProfessor = getUser?.isProfessor ?? false;
          final List<AvailableTimeEntity>? times = context
              .read<ManageProfileCubit>()
              .user
              ?.office
              ?.availability
              ?.times;
          return CustomScrollView(
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
                    CustomTextFormField(
                      labelText: 'SSN',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: _ssnController,
                    ),
                    const DepartmentField(),
                    if (!isProfessor) const ProgramField(),
                    if (!isProfessor) LevelField(controller: _levelController),
                    if (isProfessor)
                      CustomTextFormField(
                        labelText: 'Building',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _buildingController,
                      ),
                    if (isProfessor) ...[
                      CustomTextFormField(
                        labelText: 'Floor',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _floorController,
                      ),
                      CustomTextFormField(
                        labelText: 'Room',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _roomController,
                      ),
                      AvailableTimeItem(dayController: TextEditingController()),
                      ...?times?.map(
                        (e) => AvailableTimeItem(
                          availableTime: e,
                          dayController: TextEditingController(text: e.day),
                          index: times.indexOf(e),
                        ),
                      ),
                    ],
                    GithubField(controller: _gitHubController),
                    LinkedinField(controller: _linkedInController),
                    CustomElevatedButton(
                      onPressed: () async {
                        final String name = _nameController.text.trim();
                        final String email = _emailController.text.trim();
                        final String phone = _phoneController.text.trim();
                        final String level = _levelController.text.trim();
                        final String ssn = _ssnController.text.trim();
                        final String github = _gitHubController.text.trim();
                        final String linkedin = _linkedInController.text.trim();
                        final String building = _buildingController.text.trim();
                        final String floor = _floorController.text.trim();
                        final String room = _roomController.text.trim();

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
                          showSnackbar(
                            context,
                            'Invalid GitHub link.',
                            flag: false,
                          );
                          return;
                        }

                        if (!_isValidLinkedIn(linkedin)) {
                          showSnackbar(
                            context,
                            'Invalid LinkedIn link.',
                            flag: false,
                          );
                          return;
                        }

                        final ManageProfileCubit cubit =
                            context.read<ManageProfileCubit>()
                              ..setName(name)
                              ..setEmail(email)
                              ..setPhone(phone)
                              ..setLevel(level)
                              ..setSsn(ssn)
                              ..setGitHub(github)
                              ..setLinkedIn(linkedin)
                              ..setBuilding(building)
                              ..setFloor(floor)
                              ..setRoom(room);

                        if (cubit.user?.isValid ?? false) {
                          await cubit.update();
                          if (context.mounted) {
                            homeNavigation(context);
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
        },
      );
}

class AvailableTimeItem extends StatelessWidget {
  const AvailableTimeItem({
    required this.dayController,
    this.availableTime,
    this.index,
    super.key,
  });
  final TextEditingController dayController;
  final AvailableTimeEntity? availableTime;
  final int? index;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: CustomOutlinedButton(
      onPressed: () async {
        AvailableTimeEntity? availableTime =
            this.availableTime ?? const AvailableTimeEntity();
        await showAdaptiveDialog(
          context: context,
          builder: (_) => AlertDialog.adaptive(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  labelText: 'Day',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  controller: dayController,
                  onChanged: (value) {
                    availableTime = availableTime?.copyWith(day: value);
                  },
                ),
                CustomOutlinedButton(
                  text: availableTime?.from?.format(context) ?? 'From',
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      availableTime = availableTime?.copyWith(from: time);
                    }
                  },
                ),
                const SizedBox(height: 24),
                CustomOutlinedButton(
                  text: availableTime?.to?.format(context) ?? 'To',
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      availableTime = availableTime?.copyWith(to: time);
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const EText('Add'),
                onPressed: () {
                  if (availableTime
                          ?.copyWith(day: dayController.text)
                          .isValid() ??
                      false) {
                    context.read<ManageProfileCubit>().setAvailableTime(
                      availableTime!.copyWith(day: dayController.text),
                      index,
                    );
                    popNavigation(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: EText('Please enter valid time')),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
      text: availableTime?.toFormattedString(context) ?? 'Add',
    ),
  );
}
