import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_demo/chat/enum/chat_roles.enum.dart';

import 'chat_message.dto.dart';

part 'user_message.dto.mapper.dart';

@MappableClass()
class UserMessage extends ChatMessage with UserMessageMappable {
  const UserMessage({
    required super.content,
    super.createdAt,
    super.hidden,
  }) : super(role: MessageRole.user);

  static const fromMap = UserMessageMapper.fromMap;
  static const fromJson = UserMessageMapper.fromJson;
}
