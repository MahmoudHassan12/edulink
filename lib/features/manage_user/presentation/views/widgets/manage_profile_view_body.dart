import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/helpers/text_id_generator.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:edu_link/core/widgets/buttons/custom_elevated_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_form.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/department_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/description_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/level_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/semester_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/type_field.dart';
import 'package:edu_link/features/manage_user/presentation/views/widgets/email_field.dart'
    show EmailField;
import 'package:edu_link/features/manage_user/presentation/views/widgets/name_field.dart'
    show NameField;
import 'package:edu_link/features/manage_user/presentation/views/widgets/pick_image.dart'
    show PickImage;
import 'package:flutter/material.dart';

class ManageProfileViewBody extends StatefulWidget {
  const ManageProfileViewBody({super.key, this.user});
  final UserEntity? user;
  @override
  State<ManageProfileViewBody> createState() => _ManageCourseViewBodyState();
}

class _ManageCourseViewBodyState extends State<ManageProfileViewBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _levelController;
  late final TextEditingController _departmentController;
  late final TextEditingController _programController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    final user = widget.user;
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _levelController = TextEditingController(text: user?.level);
    _departmentController = TextEditingController(text: user?.department);
    _programController = TextEditingController(text: user?.program);
    _phoneController = TextEditingController(text: user?.phone);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _levelController.dispose();
    _departmentController.dispose();
    _programController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      PickImage(imageUrl: widget.user?.imageUrl),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const SizedBox(height: 16),
            NameField(controller: _nameController),
            EmailField(controller: _emailController),
            Row(
              spacing: 16,
              children: [
                Expanded(child: LevelField(controller: _levelController)),
              ],
            ),
            DepartmentField(controller: _departmentController),
            Row(
              spacing: 16,
              children: [
                Expanded(child: SemesterField(controller: _programController)),
                Expanded(child: TypeField(controller: _departmentController)),
              ],
            ),
            DescriptionField(controller: _phoneController),
            CustomElevatedButton(
              onPressed: () async {
                final user = UserEntity(
                  id: TextIdGenerator(_nameController.text).generateId(),
                  name: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  // TODO(Mahmoud): شوف هاترفع الصور إزاي
                  imageUrl: widget.user?.imageUrl ?? '',
                  department: _departmentController.text,
                  level: _levelController.text,

                  program: _programController.text,
                  ssn: _departmentController.text,
                );
                if (user.isValid()) {
                  widget.user != null
                      ? await const UserRepo().update(data: user.toMap())
                      : await const UserRepo().add(
                        data: user.toMap(),
                        documentId: user.id,
                      );
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
