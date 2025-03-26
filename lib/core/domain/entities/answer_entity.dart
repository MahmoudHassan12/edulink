import 'package:edu_link/core/domain/entities/user_entity.dart';

class AnswerEntity {
  const AnswerEntity({this.answer, this.user, this.date});
  final String? answer;
  final UserEntity? user;
  final DateTime? date;
}
