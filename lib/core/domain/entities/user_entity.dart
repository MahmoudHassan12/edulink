import 'package:edu_link/core/domain/entities/course_entity.dart';
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
    office: complexEntity(data?['office'], OfficeEntity.fromMap),
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

/// The office of a professor and its availability
class OfficeEntity {
  const OfficeEntity({this.location, this.availability, this.contactInfo});
  factory OfficeEntity.fromMap(Map<String, dynamic>? data) => OfficeEntity(
    location: complexEntity(data?['location'], LocationEntity.fromMap),
    availability: complexEntity(
      data?['availability'],
      AvailabilityEntity.fromMap,
    ),
    contactInfo: data?['contactInfo'],
  );
  final LocationEntity? location;
  final AvailabilityEntity? availability;
  final String? contactInfo;
}

/// The location of a professor
class LocationEntity {
  const LocationEntity({this.building, this.floor, this.department, this.room});
  factory LocationEntity.fromMap(Map<String, dynamic>? data) => LocationEntity(
    building: data?['building'],
    floor: data?['floor'],
    department: data?['department'],
    room: data?['room'],
  );
  final String? building;
  final String? floor;
  final String? department;
  final String? room;
}

/// The available times for a professor to respond to students
class AvailabilityEntity {
  const AvailabilityEntity({this.times});
  factory AvailabilityEntity.fromMap(Map<String, dynamic>? data) =>
      AvailabilityEntity(
        times: complexListEntity(data?['times'], AvailableTimeEntity.fromMap),
      );
  final List<AvailableTimeEntity>? times;
}

/// The available time per day for a professor to respond to students
class AvailableTimeEntity {
  const AvailableTimeEntity({this.day, this.from, this.to});
  factory AvailableTimeEntity.fromMap(Map<String, dynamic>? data) =>
      AvailableTimeEntity(
        day: data?['day'],
        from: data?['from'],
        to: data?['to'],
      );
  final String? day;
  final DateTime? from;
  final DateTime? to;
}
