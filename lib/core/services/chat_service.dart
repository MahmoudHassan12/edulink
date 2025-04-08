import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/message_entity.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String getChatId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  Stream<List<Message>> getChatMessages(String userId1, String userId2) {
    final chatId = getChatId(userId1, userId2);

    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Message.fromFirestore(doc.data(), doc.id);
          }).toList();
        });
  }

  Future<void> sendMessage(
    String userId1,
    String userId2,
    Message message,
  ) async {
    final chatId = getChatId(userId1, userId2);
    await _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toFirestore());
  }

  Future<void> createChat(String userId1, String userId2) async {
    final chatId = getChatId(userId1, userId2);
    await _db.collection('chats').doc(chatId).set({
      'users': [userId1, userId2],
    });
  }
}
