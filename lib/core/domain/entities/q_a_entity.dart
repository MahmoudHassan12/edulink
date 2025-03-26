import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';

class QAEntity {
  const QAEntity({this.question, this.answers, this.user, this.date});
  final String? question;
  final List<AnswerEntity>? answers;
  final UserEntity? user;
  final DateTime? date;
}
