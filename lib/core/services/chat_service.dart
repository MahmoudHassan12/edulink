import 'package:edu_link/core/domain/entities/chat_entity.dart';
import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
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
      .getDocumentStream(
        path: 'chats',
        documentId: _getChatId(userId1, userId2),
      )
      .map((doc) => ChatEntity.fromMap(doc.data()));

  Stream<List<ChatEntity>> getChates() => _fireStore
      .getMultibleDocumentStreamWithSpecificIds(
        path: 'chats',
        field: 'usersIds',
        documentId: getUser?.id,
      )
      .map(
        (docs) => docs.map((doc) => ChatEntity.fromMap(doc.data())).toList(),
      );

  Future<void> sendMessage(
    String userId1,
    String userId2,
    MessageEntity message,
  ) => _fireStore.addListInDocument(
    path: 'chats',
    listKey: 'messages',
    list: [message.toMap()],
    documentId: _getChatId(userId1, userId2),
  );

  Future<void> _createChat(String userId1, String userId2) {
    final chat = ChatEntity(
      users: [UserEntity(id: userId1), UserEntity(id: userId2)],
      messages: [],
    );
    return _fireStore.addDocument(
      data: chat.toMap(),
      path: 'chats',
      documentId: _getChatId(userId1, userId2),
    );
  }

  Future<bool> _isChatExist(String userId1, String userId2) => _fireStore
      .getDocument(path: 'chats', documentId: _getChatId(userId1, userId2))
      .then((doc) => doc.exists);

  Future<void> init(String userId1, String userId2) async {
    if (await _isChatExist(userId1, userId2)) return;
    return _createChat(userId1, userId2);
  }
}
