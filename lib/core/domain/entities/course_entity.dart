import 'package:edu_link/core/domain/entities/duration_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;

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

  /// Factory constructor to create `CourseEntity` from a Firestore map
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
      creditHour: (data['creditHour'] as num?)?.toInt(),
      lectures: (data['lectures'] as num?)?.toInt(),
      duration:
          data['duration'] != null
              ? DurationEntity.fromMap(
                data['duration'] as Map<String, dynamic>?,
              )
              : null,
      professor: UserEntity.fromMap(
        UserEntity(id: data['professorId']).toMap(),
      ),
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
  final UserEntity? professor;

  /// Converts `CourseEntity` to a Firestore-compatible map
  Map<String, dynamic> toMap() => {
    'id': id,
    'code': code,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'type': type,
    'level': level,
    'department': department,
    'semester': semester,
    'creditHour': creditHour,
    'lectures': lectures,
    'duration': duration?.toMap(),
    'professorId': professor?.id,
  };

  CourseEntity copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? imageUrl,
    String? type,
    String? level,
    String? department,
    String? semester,
    int? creditHour,
    int? lectures,
    DurationEntity? duration,
    UserEntity? professor,
  }) => CourseEntity(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    type: type ?? this.type,
    level: level ?? this.level,
    department: department ?? this.department,
    semester: semester ?? this.semester,
    creditHour: creditHour ?? this.creditHour,
    lectures: lectures ?? this.lectures,
    duration: duration ?? this.duration,
    professor: professor ?? this.professor,
  );

  bool isValid() =>
      (code?.isNotEmpty ?? false) &&
      (title?.isNotEmpty ?? false) &&
      (type?.isNotEmpty ?? false) &&
      (level?.isNotEmpty ?? false) &&
      (department?.isNotEmpty ?? false) &&
      (semester?.isNotEmpty ?? false);
}
