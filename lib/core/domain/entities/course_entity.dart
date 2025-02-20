import 'package:edu_link/core/domain/entities/duration_entity.dart';
import 'package:edu_link/core/domain/entities/professor_entity.dart';

class CourseEntity {
  const CourseEntity({
    this.id,
    this.code,
    this.title,
    this.description,
    this.imageUrl,
    this.type,
    this.level,
    this.department,
    this.semester,
    this.creditHour,
    this.lectures,
    this.duration,
    this.professor,
  });
  final String? id;
  final String? code;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? type;
  final String? level;
  final String? department;
  final String? semester;
  final int? creditHour;
  final int? lectures;
  final DurationEntity? duration;
  final UserEntity? professor;
}
