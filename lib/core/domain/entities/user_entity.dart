import 'dart:io' show File;
import 'package:edu_link/core/domain/entities/department_entity.dart';
import 'package:edu_link/core/domain/entities/office_entity.dart';
import 'package:edu_link/core/domain/entities/program_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';
import 'package:edu_link/core/helpers/pick_image.dart' show pickImage;
import 'package:firebase_auth/firebase_auth.dart' show User;

class UserEntity {
  const UserEntity({
    this.id,
    this.fcmToken,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.imageUrl,
    this.linkedInLink,
    this.gitHubLink,
    this.department,
    this.level,
    this.coursesIds,
    this.isProfessor,
    this.program,
    this.ssn,
    this.academicTitle,
    this.office,
  });

  factory UserEntity.fromFireBase(User? user) => UserEntity(
    id: user?.uid,
    name: user?.displayName,
    email: user?.email,
    phone: user?.phoneNumber,
    imageUrl: user?.photoURL,
  );

  factory UserEntity.fromMap(Map<String, dynamic>? data) => UserEntity(
    id: data?['id'],
    fcmToken: data?['fcmToken'],
    name: data?['name'],
    email: data?['email'],
    phone: data?['phone'],
    imageUrl: data?['imageUrl'],
    linkedInLink: data?['linkedInLink'],
    gitHubLink: data?['gitHubLink'],
    department: DepartmentEntity.fromMap(data?['department']),
    level: data?['level'],
    coursesIds: ListHandler.parseSimple(data?['coursesIds']),
    isProfessor: data?['isProfessor'],
    program: ProgramEntity.fromMap(data?['program']),
    ssn: data?['ssn'],
    academicTitle: data?['academicTitle'],
    office: OfficeEntity.fromMap(data?['office']),
  );

  final String? id;
  final String? fcmToken;

  final String? name;
  final String? email;
  final String? phone;
  final File? image;
  final String? imageUrl;
  final String? linkedInLink;
  final String? gitHubLink;
  final DepartmentEntity? department;
  final String? level;
  final List<String>? coursesIds;
  final bool? isProfessor;
  final ProgramEntity? program;
  final String? ssn;
  final String? academicTitle;
  final OfficeEntity? office;

  Map<String, dynamic> toMap() => {
    'id': id,
    'fcmToken': fcmToken,
    'name': name,
    'email': email,
    'phone': phone,
    'imageUrl': imageUrl,
    'linkedInLink': linkedInLink,
    'gitHubLink': gitHubLink,
    'department': department?.toMap(),
    'level': level,
    'coursesIds': coursesIds,
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
    File? image,
    String? imageUrl,
    String? linkedInLink,
    String? gitHubLink,
    DepartmentEntity? department,
    String? level,
    List<String>? coursesIds,
    bool? isProfessor,
    ProgramEntity? program,
    String? ssn,
    String? academicTitle,
    OfficeEntity? office,
  }) => UserEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    gitHubLink: gitHubLink ?? this.gitHubLink,
    linkedInLink: linkedInLink ?? this.linkedInLink,
    phone: phone ?? this.phone,
    image: image ?? this.image,
    imageUrl: imageUrl ?? this.imageUrl,
    department: department ?? this.department,
    level: level ?? this.level,
    coursesIds: coursesIds ?? this.coursesIds,
    isProfessor: isProfessor ?? this.isProfessor,
    program: program ?? this.program,
    ssn: ssn ?? this.ssn,
    academicTitle: academicTitle ?? this.academicTitle,
    office: office ?? this.office,
  );
  UserEntity setName(String name) => copyWith(name: name);
  UserEntity setEmail(String email) => copyWith(email: email);
  UserEntity setGitHub(String githubLink) => copyWith(gitHubLink: githubLink);
  UserEntity setLinkedIn(String linkedinLink) =>
      copyWith(linkedInLink: linkedinLink);

  UserEntity setPhone(String phone) => copyWith(phone: phone);
  Future<UserEntity> setImage() async => copyWith(image: await pickImage());
  UserEntity setImageUrl(String imageUrl) => copyWith(imageUrl: imageUrl);
  UserEntity setDepartment(DepartmentEntity department) =>
      copyWith(department: department);
  UserEntity setLevel(String level) => copyWith(level: level);
  UserEntity setProgram(ProgramEntity program) => copyWith(program: program);
  UserEntity setSsn(String ssn) => copyWith(ssn: ssn);
  UserEntity setAcademicTitle(String academicTitle) =>
      copyWith(academicTitle: academicTitle);
  UserEntity setOffice(OfficeEntity office) => copyWith(office: office);

  bool get isValid =>
      (name?.isNotEmpty ?? false) &&
      (email?.isNotEmpty ?? false) &&
      (phone?.isNotEmpty ?? false) &&
      (department?.isValid ?? false) &&
      (level?.isNotEmpty ?? false) &&
      (program?.isValid ?? false) &&
      (ssn?.isNotEmpty ?? false);
}
