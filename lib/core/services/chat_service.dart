import 'package:edu_link/core/domain/entities/chat_entity.dart';
import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/helpers/query_entity.dart';
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;

class ChatService {
  const ChatService();
  static const FirestoreService _fireStore = FirestoreService();

  String _getChatId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  Stream<ChatEntity> getChat(String userId1, String userId2) => _fireStore
      .streamDocument(path: 'chats', documentId: _getChatId(userId1, userId2))
      .map((data) => ChatEntity.fromMap(data));

  Stream<List<ChatEntity>> getChates() => _fireStore
      .streamCollectionWithQuery(
        path: 'chats',
        query: QueryEntity(
          fields: [FieldEntity(field: 'usersIds', arrayContains: getUser?.id)],
        ),
      )
      .map((e) => e.map((data) => ChatEntity.fromMap(data)).toList());

  Future<void> sendMessage(
    String userId1,
    String userId2,
    MessageEntity message,
  ) => _fireStore.addValue(
    path: 'chats',
    documentId: _getChatId(userId1, userId2),
    key: 'messages',
    data: [message.toMap()],
  );

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
    if (await _isChatExist(userId1, userId2)) return;
    return _createChat(userId1, userId2);
  }
}
