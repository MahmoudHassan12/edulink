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

  /// Function to convert Firestore data into a `CourseEntity`
  factory CourseEntity.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return const CourseEntity(); // Return an empty entity if data is null
    }

    return CourseEntity(
      id: data['id'] as String?,
      code: data['code'] as String?,
      title: data['title'] as String?,
      description: data['description'] as String?,
      imageUrl: data['imageUrl'] as String?,
      type: data['type'] as String?,
      level: data['level'] as String?,
      department: data['department'] as String?,
      semester: data['semester'] as String?,
      creditHour:
          (data['creditHour'] as num?)
              ?.toInt(), // Ensures safe conversion from Firestore's num type
      lectures: (data['lectures'] as num?)?.toInt(),
      duration:
          data['duration'] != null
              ? DurationEntity.fromMap(data['duration'] as Map<String, dynamic>)
              : null, // Handle null safely
      professor:
          data['professor'] != null
              ? ProfessorEntity.fromMap(
                data['professor'] as Map<String, dynamic>,
              )
              : null, // Handle null safely
    );
  }

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
  final ProfessorEntity? professor;
}
