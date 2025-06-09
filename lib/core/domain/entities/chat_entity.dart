import 'package:edu_link/core/domain/entities/message_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart' show ListHandler;

class ChatEntity {
  const ChatEntity({this.messages, this.users});
  factory ChatEntity.fromMap(Map<String, dynamic>? map) => ChatEntity(
    messages: ListHandler.parseComplex<MessageEntity>(
      map?['messages'],
      MessageEntity.fromMap,
    ),
    users: List<UserEntity>.from(
      (map?['usersIds'] as List<dynamic>).map((id) => UserEntity(id: id)),
    ),
  );
  final List<MessageEntity>? messages;
  final List<UserEntity>? users;

  ChatEntity copyWith({
    List<MessageEntity>? messages,
    List<UserEntity>? users,
  }) => ChatEntity(
    messages: messages ?? this.messages,
    users: users ?? this.users,
  );
  Map<String, dynamic> toMap() => {
    'messages': messages?.map((e) => e.toMap()).toList(),
    'usersIds': users?.map((e) => e.id).toList(),
  };
}
