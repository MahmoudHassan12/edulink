import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';

class QuestionEntity {
  const QuestionEntity({this.question, this.answers, this.user, this.date});
  factory QuestionEntity.fromMap(Map<String, dynamic>? data) => QuestionEntity(
    question: data?['question'],
    answers: complexListEntity(data?['answers'], AnswerEntity.fromMap),
    user:
        data?['user'] != null
            ? UserEntity.fromMap(data?['user'])
            : UserEntity(id: data?['userId']),
    date:
        data?['date'] is String ? DateTime.parse(data?['date']) : data?['date'],
  );
  final String? question;
  final List<AnswerEntity>? answers;
  final UserEntity? user;
  final DateTime? date;
  Map<String, dynamic> toMap({bool toSharedPref = false}) => {
    'question': question,
    'answers':
        answers?.map((e) => e.toMap(toSharedPref: toSharedPref)).toList(),
    if (toSharedPref)
      'user': user?.toMap(toSharedPref: true)
    else
      'userId': user?.id,
    'date': toSharedPref ? date?.toIso8601String() : date,
  };
  QuestionEntity copyWith({
    String? question,
    List<AnswerEntity>? answers,
    UserEntity? user,
    DateTime? date,
  }) => QuestionEntity(
    question: question ?? this.question,
    answers: answers ?? this.answers,
    user: user ?? this.user,
    date: date ?? this.date,
  );
  QuestionEntity setQuestion(String question) => copyWith(question: question);
  QuestionEntity setUser(UserEntity user) => copyWith(user: user);
  QuestionEntity setDate(DateTime date) => copyWith(date: date);
}
