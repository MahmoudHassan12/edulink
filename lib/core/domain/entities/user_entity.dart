import 'package:edu_link/core/domain/entities/course_entity.dart';

class UserEntity {
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.department,
    this.level,
    this.courses = const [], // Default empty list
    this.isProfessor = false,
    this.program,
    this.ssn,
    this.academicTitle,
    this.office,
  });

  /// Convert Firestore data to `StudentEntity`
  factory UserEntity.fromMap(
    Map<String, dynamic>? data, {
    List<CourseEntity>? courses,
  }) => UserEntity(
    id: data?['id'],
    name: data?['name'],
    email: data?['email'],
    phone: data?['phone'],
    imageUrl: data?['imageUrl'],
    department: data?['department'],
    level: data?['level'],
    courses: courses ?? [],
    isProfessor: data?['isProfessor'],
    program: data?['program'],
    ssn: data?['ssn'],
    academicTitle: data?['academicTitle'],
    office:
        data?['office'] != null ? OfficeEntity.fromMap(data?['office']) : null,
  );

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? department;
  final String? level;
  final List<CourseEntity>? courses;
  final bool isProfessor;

  /// For students
  final String? program;
  final String? ssn;

  /// For professors
  final String? academicTitle;
  final OfficeEntity? office;
}

class OfficeEntity {
  const OfficeEntity({this.location, this.hours, this.contactInfo});
  factory OfficeEntity.fromMap(Map<String, dynamic>? data) => OfficeEntity(
    location: data?['location'],
    hours: data?['hours'],
    contactInfo: data?['contactInfo'],
  );
  final String? location;
  final String? hours;
  final String? contactInfo;
}
