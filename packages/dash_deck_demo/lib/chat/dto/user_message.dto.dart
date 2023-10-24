import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';

import 'chat_message.dto.dart';

part 'user_message.dto.mapper.dart';

@MappableClass()
class UserChatMessage extends ChatMessage with UserChatMessageMappable {
  UserChatMessage({
    required super.content,
    required super.createdAt,
    super.hidden = false,
  }) : super(role: MessageRole.user);

  static const fromMap = UserChatMessageMapper.fromMap;
  static const fromJson = UserChatMessageMapper.fromJson;
}
