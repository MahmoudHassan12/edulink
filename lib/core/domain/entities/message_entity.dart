import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class Message {
  Message({this.userId, this.text, this.date, this.id});

  factory Message.fromFirestore(Map<String, dynamic> data, String messageId) {
    final date = switch (data['date']) {
      Timestamp t => t.toDate(),
      DateTime d => d,
      _ => DateTime.now(),
    };
    return Message(
      userId: data['userId'],
      text: data['text'],
      date: date,
      id: messageId,
    );
  }
  final String? userId;
  final String? text;
  final DateTime? date;
  final String? id;

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'text': text,
    'date': date,
    'id': id,
  };
}
