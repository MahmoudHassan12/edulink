import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class Message {
  Message({
    required this.userId,
    required this.text,
    required this.timestamp,
    required this.messageId,
  });

  factory Message.fromFirestore(Map<String, dynamic> data, String messageId) {
    return Message(
      userId: data['userId'],
      text: data['text'],
      timestamp: (data['timestamp'] as Timestamp).millisecondsSinceEpoch,
      messageId: messageId,
    );
  }
  final String userId;
  final String text;
  final int timestamp;
  final String messageId;

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'text': text,
      'timestamp': Timestamp.fromMillisecondsSinceEpoch(timestamp),
    };
  }
}
