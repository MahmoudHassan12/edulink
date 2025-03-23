import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/department_entity.dart';
import 'package:edu_link/core/domain/entities/office_entity.dart';
import 'package:edu_link/core/domain/entities/program_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';

class UserEntity {
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.department,
    this.level,
    this.courses = const [],
    this.isProfessor,
    this.program,
    this.ssn,
    this.academicTitle,
    this.office,
  });

  factory UserEntity.fromMap(Map<String, dynamic>? data) => UserEntity(
    id: data?['id'],
    name: data?['name'],
    email: data?['email'],
    phone: data?['phone'],
    imageUrl: data?['imageUrl'],
    department: complexEntity(data?['department'], DepartmentEntity.fromMap),
    level: data?['level'],
    courses: complexListEntity(data?['courses'], CourseEntity.fromMap),
    isProfessor: data?['isProfessor'],
    program: complexEntity(data?['program'], ProgramEntity.fromMap),
    ssn: data?['ssn'],
    academicTitle: data?['academicTitle'],
    office: complexEntity(data?['office'], OfficeEntity.fromMap),
  );

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final DepartmentEntity? department;
  final String? level;
  final List<CourseEntity>? courses;
  final bool? isProfessor;
  final ProgramEntity? program;
  final String? ssn;
  final String? academicTitle;
  final OfficeEntity? office;

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'imageUrl': imageUrl,
    'department': department?.toMap(),
    'level': level,
    'courses': courses?.map((course) => course.toMap()).toList(),
    'isProfessor': isProfessor ?? false,
    'program': program?.toMap(),
    'ssn': ssn,
    'academicTitle': academicTitle,
    'office': office?.toMap(),
  };

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    DepartmentEntity? department,
    String? level,
    List<CourseEntity>? courses,
    bool? isProfessor,
    ProgramEntity? program,
    String? ssn,
    String? academicTitle,
    OfficeEntity? office,
  }) => UserEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    imageUrl: imageUrl ?? this.imageUrl,
    department: department ?? this.department,
    level: level ?? this.level,
    courses: courses ?? this.courses,
    isProfessor: isProfessor ?? this.isProfessor,
    program: program ?? this.program,
    ssn: ssn ?? this.ssn,
    academicTitle: academicTitle ?? this.academicTitle,
    office: office ?? this.office,
  );

  UserEntity setName(String name) => copyWith(name: name);
  UserEntity setEmail(String email) => copyWith(email: email);
  UserEntity setPhone(String phone) => copyWith(phone: phone);
  UserEntity setImageUrl(String imageUrl) => copyWith(imageUrl: imageUrl);
  UserEntity setDepartment(DepartmentEntity department) =>
      copyWith(department: department);
  UserEntity setLevel(String level) => copyWith(level: level);
  UserEntity setProgram(ProgramEntity program) => copyWith(program: program);
  UserEntity setSsn(String ssn) => copyWith(ssn: ssn);
  UserEntity setAcademicTitle(String academicTitle) =>
      copyWith(academicTitle: academicTitle);
  UserEntity setOffice(OfficeEntity office) => copyWith(office: office);

  bool isValid() =>
      (name?.isNotEmpty ?? false) &&
      (email?.isNotEmpty ?? false) &&
      (phone?.isNotEmpty ?? false) &&
      (department?.isValid() ?? false) &&
      (level?.isNotEmpty ?? false) &&
      (program?.isValid() ?? false) &&
      (ssn?.isNotEmpty ?? false);
}
