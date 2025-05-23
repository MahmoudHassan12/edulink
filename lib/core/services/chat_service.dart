import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, FirebaseFirestore;
import 'package:edu_link/core/domain/entities/chat_entity.dart';
import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/query_entity.dart';
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;
import 'package:flutter/services.dart' show rootBundle;
import 'package:smart_notification_manager/core/models/notifier_models/push_notifier_model.dart'
    show PushNotificationModel;
import 'package:smart_notification_manager/core/services/notifier_sender/push_notifier_sender.dart'
    show PushNotificationSender;
import 'package:smart_notification_manager/core/utils/push_notification_type.dart'
    show PushNotificationType;

class ChatService {
  const ChatService();
  static const _fireStore = FirestoreService();

  String _getChatId(String userId1, String userId2) =>
      userId1.compareTo(userId2) < 0
      ? '${userId1}_$userId2'
      : '${userId2}_$userId1';

  Stream<ChatEntity> getChat(String userId1, String userId2) => _fireStore
      .streamDocument(path: 'chats', documentId: _getChatId(userId1, userId2))
      .map(ChatEntity.fromMap);

  Stream<List<ChatEntity>> getChates() => _fireStore
      .streamCollectionWithQuery(
        path: 'chats',
        query: QueryEntity(
          fields: [FieldEntity(field: 'usersIds', arrayContains: getUser?.id)],
        ),
      )
      .map((e) => e.map(ChatEntity.fromMap).toList());

  Future<void> sendMessage(
    String userId1,
    String userId2,
    MessageEntity message,
  ) async {
    final DocumentSnapshot<Map<String, dynamic>> receiverDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId2).get();

    final DocumentSnapshot<Map<String, dynamic>> senderDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId1).get();
    final senderUsername = senderDoc.data()?['name'];
    final token = receiverDoc.data()?['fcmToken'];

    if (token != null) {
      final String serviceAccountJson = await rootBundle.loadString(
        'assets/service_account.json',
      );

      await PushNotificationSender().sendNotification(
        PushNotificationModel(
          json: serviceAccountJson,
          projectId: 'edu-link-16',
          title: 'New Message $senderUsername',
          body: message.text ?? 'You have a new message',
          token: token,
          type: PushNotificationType.byToken,

          data: {
            'type': 'chat',
            'senderId': userId1,
            'receiverId': userId2,
            'chatId': _getChatId(userId1, userId2),
          },
        ),
      );
    }

    return _fireStore.addValue(
      path: 'chats',
      documentId: _getChatId(userId1, userId2),
      key: 'messages',
      data: [message.toMap()],
    );
  }

  Future<void> _createChat(String userId1, String userId2) {
    final chat = ChatEntity(
      users: [
        UserEntity(id: userId1),
        UserEntity(id: userId2),
      ],
      messages: [],
    );
    return _fireStore.addDocument(
      data: chat.toMap(),
      path: 'chats',
      documentId: _getChatId(userId1, userId2),
    );
  }

  Future<bool> _isChatExist(String userId1, String userId2) =>
      _fireStore.isDocumentExists(
        path: 'chats',
        documentId: _getChatId(userId1, userId2),
      );

  Future<void> init(String userId1, String userId2) async {
    if (await _isChatExist(userId1, userId2)) {
      return;
    }
    return _createChat(userId1, userId2);
  }
}
