import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';
import 'package:flutter/material.dart' show TimeOfDay;


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
    this.isProfessor = false,
    this.program,
    this.ssn,
    this.academicTitle,
    this.office,
  });

  factory UserEntity.fromMap(
    Map<String, dynamic>? data, {
    List<CourseEntity>? courses,
  }) =>
      UserEntity(
        id: data?['id'],
        name: data?['name'],
        email: data?['email'],
        phone: data?['phone'],
        imageUrl: data?['imageUrl'],
        department: data?['department'],
        level: data?['level'],
        courses: courses ?? [],
        isProfessor: data?['isProfessor'] ?? false,
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
  final String? program;
  final String? ssn;
  final String? academicTitle;
  final OfficeEntity? office;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'department': department,
      'level': level,
      'courses': courses?.map((course) => course.toMap()).toList(),
      'isProfessor': isProfessor,
      'program': program,
      'ssn': ssn,
      'academicTitle': academicTitle,
      'office': office?.toMap(),
    };
  }
}

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

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      'availability': availability?.toMap(),
      'contactInfo': contactInfo,
    };
  }
}

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

  Map<String, dynamic> toMap() {
    return {
      'building': building,
      'floor': floor,
      'department': department,
      'room': room,
    };
  }
}

class AvailabilityEntity {
  const AvailabilityEntity({this.times});

  factory AvailabilityEntity.fromMap(Map<String, dynamic>? data) =>
      AvailabilityEntity(
        times: complexListEntity(data?['times'], AvailableTimeEntity.fromMap),
      );

  final List<AvailableTimeEntity>? times;

  Map<String, dynamic> toMap() {
    return {
      'times': times?.map((time) => time.toMap()).toList(),
    };
  }
}

class AvailableTimeEntity {
  const AvailableTimeEntity({this.day, this.from, this.to});

  factory AvailableTimeEntity.fromMap(Map<String, dynamic>? data) =>
      AvailableTimeEntity(
        day: data?['day'],
        from: data?['from'] != null
            ? TimeOfDay(
                hour: data?['from']['hour'] ?? 0,
                minute: data?['from']['minute'] ?? 0,
              )
            : null,
        to: data?['to'] != null
            ? TimeOfDay(
                hour: data?['to']['hour'] ?? 0,
                minute: data?['to']['minute'] ?? 0,
              )
            : null,
      );

  final String? day;
  final TimeOfDay? from;
  final TimeOfDay? to;

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'from': from != null ? {'hour': from!.hour, 'minute': from!.minute} : null,
      'to': to != null ? {'hour': to!.hour, 'minute': to!.minute} : null,
    };
  }
}
