import 'dart:io' show File;
import 'package:edu_link/core/domain/entities/duration_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/entities_handlers.dart' show ListHandler;
import 'package:edu_link/core/helpers/pick_image.dart' show pickImage;
import 'package:edu_link/core/helpers/text_id_generator.dart'
    show TextIdGenerator;

class CourseEntity {
  const CourseEntity({
    this.id,
    this.code,
    this.title,
    this.description,
    this.image,
    this.imageUrl,
    this.type,
    this.level,
    this.department,
    this.semester,
    this.creditHour,
    this.lectures,
    this.duration,
    this.professor,
    this.questions,
  });

  /// Factory constructor to create `CourseEntity` from a Firestore map
  factory CourseEntity.fromMap(Map<String, dynamic>? data) {
    final professor = data?['professor'] != null
        ? UserEntity.fromMap(data?['professor'])
        : UserEntity(id: data?['professorId']);
    return CourseEntity(
      id: data?['id'],
      code: data?['code'],
      title: data?['title'],
      description: data?['description'],
      imageUrl: data?['imageUrl'],
      type: data?['type'],
      level: data?['level'],
      department: data?['department'],
      semester: data?['semester'],
      creditHour: data?['creditHour'],
      lectures: data?['lectures'],
      duration: DurationEntity.fromMap(data?['duration']),
      professor: professor,
      questions: ListHandler.parseComplex(
        data?['questions'],
        QuestionEntity.fromMap,
      ),
    );
  }

  final String? id;
  final String? code;
  final String? title;
  final String? description;
  final File? image;
  final String? imageUrl;
  final String? type;
  final String? level;
  final String? department;
  final String? semester;
  final int? creditHour;
  final int? lectures;
  final DurationEntity? duration;
  final UserEntity? professor;
  final List<QuestionEntity>? questions;

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
    'questions': questions?.map((e) => e.toMap()).toList(),
  };

  CourseEntity copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    File? image,
    String? imageUrl,
    String? type,
    String? level,
    String? department,
    String? semester,
    int? creditHour,
    int? lectures,
    DurationEntity? duration,
    UserEntity? professor,
    List<QuestionEntity>? questions,
  }) => CourseEntity(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    description: description ?? this.description,
    image: image ?? this.image,
    imageUrl: imageUrl ?? this.imageUrl,
    type: type ?? this.type,
    level: level ?? this.level,
    department: department ?? this.department,
    semester: semester ?? this.semester,
    creditHour: creditHour ?? this.creditHour,
    lectures: lectures ?? this.lectures,
    duration: duration ?? this.duration,
    professor: professor ?? this.professor,
    questions: questions ?? this.questions,
  );

  CourseEntity setId(String id) =>
      copyWith(id: TextIdGenerator(id).generateId());
  CourseEntity setCode(String code) => copyWith(code: code);
  CourseEntity setTitle(String title) => copyWith(title: title);
  CourseEntity setDescription(String description) =>
      copyWith(description: description);
  Future<CourseEntity> setImage() async => copyWith(image: await pickImage());
  CourseEntity setImageUrl(String imageUrl) => copyWith(imageUrl: imageUrl);
  CourseEntity setType(String type) => copyWith(type: type);
  CourseEntity setLevel(String level) => copyWith(level: level);
  CourseEntity setDepartment(String department) =>
      copyWith(department: department);
  CourseEntity setSemester(String semester) => copyWith(semester: semester);
  CourseEntity setCreditHour(int creditHour) =>
      copyWith(creditHour: creditHour);
  CourseEntity setLectures(int lectures) => copyWith(lectures: lectures);
  CourseEntity setDuration(DurationEntity duration) =>
      copyWith(duration: duration);
  CourseEntity setProfessor(UserEntity professor) =>
      copyWith(professor: professor);
  bool get isValid =>
      (code?.isNotEmpty ?? false) &&
      (title?.isNotEmpty ?? false) &&
      (type?.isNotEmpty ?? false) &&
      (level?.isNotEmpty ?? false) &&
      (department?.isNotEmpty ?? false) &&
      (semester?.isNotEmpty ?? false);
}
