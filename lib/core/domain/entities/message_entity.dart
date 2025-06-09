import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:edu_link/core/domain/entities/user_entity.dart';

class MessageEntity {
  MessageEntity({this.user, this.text, this.date});
  factory MessageEntity.fromMap(Map<String, dynamic>? data) {
    final DateTime date = switch (data?['date']) {
      final Timestamp t => t.toDate(),
      final DateTime d => d,
      _ => DateTime.now(),
    };
    return MessageEntity(
      user: UserEntity(id: data?['userId']),
      text: data?['text'],
      date: date,
    );
  }
  final UserEntity? user;
  final String? text;
  final DateTime? date;
  Map<String, dynamic> toMap() => {
    'userId': user?.id,
    'text': text,
    'date': date,
  };
}
