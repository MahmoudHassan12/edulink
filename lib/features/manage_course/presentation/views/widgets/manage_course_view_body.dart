import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/text_id_generator.dart';
import 'package:edu_link/core/widgets/buttons/custom_elevated_button.dart';
import 'package:edu_link/features/auth/presentation/views/widgets/sign_in/sign_in_form.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/code_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/credit_hour_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/department_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/description_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/level_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/pick_image.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/semester_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/title_field.dart';
import 'package:edu_link/features/manage_course/presentation/views/widgets/type_field.dart';
import 'package:flutter/material.dart';

class ManageCourseViewBody extends StatefulWidget {
  const ManageCourseViewBody({super.key, this.course});
  final CourseEntity? course;
  @override
  State<ManageCourseViewBody> createState() => _ManageCourseViewBodyState();
}

class _ManageCourseViewBodyState extends State<ManageCourseViewBody> {
  late final TextEditingController _codeController;
  late final TextEditingController _titleController;
  late final TextEditingController _creditHourController;
  late final TextEditingController _levelController;
  late final TextEditingController _departmentController;
  late final TextEditingController _semesterController;
  late final TextEditingController _typeController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    final course = widget.course;
    _codeController = TextEditingController(text: course?.code);
    _titleController = TextEditingController(text: course?.title);
    _creditHourController = TextEditingController(
      text: course?.creditHour.toString(),
    );
    _levelController = TextEditingController(text: course?.level);
    _departmentController = TextEditingController(text: course?.department);
    _semesterController = TextEditingController(text: course?.semester);
    _typeController = TextEditingController(text: course?.type);
    _descriptionController = TextEditingController(text: course?.description);
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditHourController.dispose();
    _levelController.dispose();
    _departmentController.dispose();
    _semesterController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      PickImage(imageUrl: widget.course?.imageUrl),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(
          children: [
            const SizedBox(height: 16),
            CodeField(controller: _codeController),
            TitleField(controller: _titleController),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: CreditHourField(controller: _creditHourController),
                ),
                Expanded(child: LevelField(controller: _levelController)),
              ],
            ),
            DepartmentField(controller: _departmentController),
            Row(
              spacing: 16,
              children: [
                Expanded(child: SemesterField(controller: _semesterController)),
                Expanded(child: TypeField(controller: _typeController)),
              ],
            ),
            DescriptionField(controller: _descriptionController),
            CustomElevatedButton(
              onPressed: () {
                final course = CourseEntity(
                  id: TextIdGenerator(_codeController.text).generateId(),
                  code: _codeController.text,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  imageUrl: '', // TODO(Mahmoud): Don't forget this line
                  level: _levelController.text,
                  department: _departmentController.text,
                  creditHour: int.tryParse(_creditHourController.text),
                  semester: _semesterController.text,
                  type: _typeController.text,
                  professor: getUser(),
                );
                if (course.isValid()) {
                  // TODO(Mahmoud): Add the course to the firestore
                  // or edit it if it's exist
                  // واتصرف وشوف هاترفع الصور إزاي
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
