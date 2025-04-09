import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/message_entity.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String _getChatId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  Stream<List<Message>> getChatMessages(String userId1, String userId2) => _db
      .collection('chats')
      .doc(_getChatId(userId1, userId2))
      .collection('messages')
      .orderBy('date', descending: true)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs
                .map((doc) => Message.fromFirestore(doc.data(), doc.id))
                .toList(),
      );

  Future<void> sendMessage(String userId1, String userId2, Message message) =>
      _db
          .collection('chats')
          .doc(_getChatId(userId1, userId2))
          .collection('messages')
          .add(message.toFirestore());

  Future<void> createChat(String userId1, String userId2) =>
      _db.collection('chats').doc(_getChatId(userId1, userId2)).set({
        'users': [userId1, userId2],
      });
}
