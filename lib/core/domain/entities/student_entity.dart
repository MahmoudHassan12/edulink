import 'package:edu_link/core/domain/entities/course_entity.dart';

class StudentEntity {
  const StudentEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.department,
    required this.level,
    required this.program,
    required this.ssn,
    this.registeredCourses = const [], // Default empty list
  });

  /// Convert Firestore data to `StudentEntity`
  factory StudentEntity.fromMap(
    Map<String, dynamic>? data, {
    List<CourseEntity>? courses,
  }) {
    if (data == null) return StudentEntity.empty();

    return StudentEntity(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      department: data['department'] as String? ?? '',
      level: data['level'] as String? ?? '',
      program: data['program'] as String? ?? '',
      ssn: data['ssn'] as String? ?? '',
      registeredCourses: courses ?? [],
    );
  }

  /// Empty instance for handling null cases
  static StudentEntity empty() {
    return const StudentEntity(
      id: '',
      name: '',
      email: '',
      phone: '',
      imageUrl: '',
      department: '',
      level: '',
      program: '',
      ssn: '',
    );
  }

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? department;
  final String? level;
  final String? program;
  final String? ssn;
  final List<CourseEntity> registeredCourses;
}
