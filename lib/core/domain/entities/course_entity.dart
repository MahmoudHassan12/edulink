import 'package:edu_link/core/domain/entities/professor_entity.dart';

class CourseEntity {
  const CourseEntity({
    this.id,
    this.code,
    this.title,
    this.description,
    this.imageUrl,
    this.duration,
    this.professor,
  });
  final String? id;
  final String? code;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? duration;
  final ProfessorEntity? professor;
}
