import 'package:edu_link/core/domain/entities/user_entity.dart';

class AnswerEntity {
  const AnswerEntity({this.answer, this.user, this.date});
  factory AnswerEntity.fromMap(Map<String, dynamic>? data) {
    final user =
        data?['user'] != null
            ? UserEntity.fromMap(data?['user'])
            : UserEntity(id: data?['userId']);
    return AnswerEntity(
      answer: data?['answer'],
      user: user,
      date: DateTime.parse(data?['date']),
    );
  }
  final String? answer;
  final UserEntity? user;
  final DateTime? date;
  Map<String, dynamic> toMap({bool toSharedPref = false}) => {
    'answer': answer,
    if (toSharedPref) 'user': user?.toMap() else 'userId': user?.id,
    'date': date,
  };
  AnswerEntity copyWith({String? answer, UserEntity? user, DateTime? date}) =>
      AnswerEntity(
        answer: answer ?? this.answer,
        user: user ?? this.user,
        date: date ?? this.date,
      );
  AnswerEntity setAnswer(String answer) => copyWith(answer: answer);
  AnswerEntity setUser(UserEntity user) => copyWith(user: user);
  AnswerEntity setDate(DateTime date) => copyWith(date: date);
}
